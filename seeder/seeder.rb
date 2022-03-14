pages << {
  page_type: "listings",
  method: "GET",
  headers: {"User-Agent" => "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36"},
  url: "https://www.goodreads.com/list/show/264.Books_That_Everyone_Should_Read_At_Least_Once",
  vars: {
    "list_name" => "Books That Everyone Should Read At Least Once",
    "page_num" => 1 # start halaman
  },
  fetch_type: "browser"
  # driver: { 
  #             code: "
  #             await page.waitForNavigation({waitUntil: 'domcontentloaded'}); 
  #             "
  # } # nunggu sampai ga ada koneksi lagi setidaknya dalam rentang 500 ms.
}