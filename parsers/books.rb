nokogiri = Nokogiri.HTML(content)

# initialize an empty hash
book = {}

#save the url
book['url'] = page['vars']['url']

# image url
book['img_url'] = "!no_image"
book['img_url'] = nokogiri.at_css('img#coverImage')["src"] unless nokogiri.at_css('img#coverImage').nil?

#save the url
book['List'] = page['vars']['list_name']

# title
book['Title'] = "!title_not_found"
book['Title'] = nokogiri.at_css('h1#bookTitle').text.strip unless nokogiri.at_css('h1#bookTitle').nil?
raise "Title not found" if book['Title'] == "!title_not_found" #penjaga aja, kali aja pagenya belum keload dengan baik

# book series
book['Series'] = "!series_not_found"
book['Series'] = nokogiri.at_css('h2#bookSeries').text.strip unless nokogiri.at_css('h2#bookSeries').nil?

# author
book['Author'] = "!author_not_found"
book['Author'] = nokogiri.at_css('span[itemprop="author"] a.authorName span').text.strip unless nokogiri.at_css('span[itemprop="author"] a.authorName span').nil?

# book rating
book["Rating"] = 0.0
book["Rating"] = nokogiri.at_css('span[itemprop="ratingValue"]').text.to_f unless nokogiri.at_css('span[itemprop="ratingValue"]').nil?

# number of votes
book["Rating Count"] = 0
book["Rating Count"] = nokogiri.at_css('meta[itemprop="ratingCount"]')["content"].to_i unless nokogiri.at_css('meta[itemprop="ratingCount"]').nil?

# number of review
book["Review Count"] = 0
book["Review Count"] = nokogiri.at_css('meta[itemprop="reviewCount"]')["content"].to_i unless nokogiri.at_css('meta[itemprop="reviewCount"]').nil?

# description
book['Description'] = "!no_description_found"
book['Description'] = nokogiri.css('div#description span').last.text.strip unless nokogiri.at_css('div#description span').nil?

# Similar Books
book['Similar Books'] = []

similar_book_node = nokogiri.css("div.clearFloats div.bookCarousel li a img")

similar_book_node.each do |sim|
    book['Similar Books'] << sim['alt']
end

# page number and book rank in that page
book['Page Number'] = page['vars']['page_num']
book['Page Rank'] = page['vars']['rank']

# specify the collection where this record will be stored
book['_collection'] = 'books'

# save the product to the job’s outputs
outputs << book