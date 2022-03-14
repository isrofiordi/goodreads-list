nokogiri = Nokogiri.HTML(content)

# Cari link semua buku di halaman
rank = 1
books_container = nokogiri.css('tbody tr') #container buku
books_container.each do |book|
    url = "https://www.goodreads.com" + book.at_css('a.bookTitle')["href"]
    score = book.css("span.smallText.uitext a")[0].text.strip.gsub(",","")[/\d+/,0].to_i
    votes = book.css("span.smallText.uitext a")[1].text.strip.gsub(",","")[/\d+/,0].to_i
    pages << {
          url: url,
          page_type: 'books',
          vars: {
              url: url,
              "list_name" => page["vars"]["list_name"],
              "score" => score,
              "votes" => votes,
              "rank" => rank,
              "page_num" => page['vars']['page_num']
            },
          fetch_type: "browser"
        #   driver: { 
        #       code: "
        #       await page.waitForNavigation({waitUntil: 'domcontentloaded'}); 
        #       "
        #   } # nunggu sampai ga ada koneksi lagi setidaknya dalam rentang 500 ms.
    }
rank += 1
end

# Fetch next page
next_page_node = nokogiri.at_css('div.pagination a.next_page')

if next_page_node
    next_page_link = "https://www.goodreads.com" + next_page_node["href"]
    pages << {
        page_type: "listings",
        method: "GET",
        headers: {"User-Agent" => "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36"},
        url: next_page_link,
        vars: {
            "list_name" => "Books That Everyone Should Read At Least Once",
            "page_num" => page['vars']['page_num'] + 1
        },
        fetch_type: "browser"
        # driver: { 
        #       code: "
        #       await page.waitForNavigation({waitUntil: 'domcontentloaded'}); 
        #       "
        # } # nunggu sampai ga ada koneksi lagi setidaknya dalam rentang 500 ms.
    }
end
