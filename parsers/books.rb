nokogiri = Nokogiri.HTML(content)

# initialize an empty hash
book = {}

#save the url
book['url'] = page['vars']['url']

# image url
book['img_url'] = nokogiri.at_css('span.cover a img')["src"]

# title
book['Title'] = nokogiri.at_css('a.winningTitle').text.strip unless nokogiri.at_css('a.winningTitle').nil?

# author
book['Author'] = nokogiri.at_css('span[itemprop="name"]').text.strip unless nokogiri.at_css('span[itemprop="name"]').nil?

# award year
book['Award Year'] = book['url'][/\d+/,0] unless book['url'].nil?

# award category
book['Award Category'] = nokogiri.at_css('div.gcaMastheader').text.strip unless nokogiri.at_css('div.gcaMastheader').nil?

# number of votes
book["Number of Votes"] = nokogiri.at_css('span.gcaNumVotes').text.strip.gsub("\n"," ") + " out of " + nokogiri.at_css('div.gcaNumVotes').text.strip.gsub("\n"," ")

# All nominees
book['Nominees'] = []

nominee_node = nokogiri.css("div.inlineblock.pollAnswer.resultShown")

nominee_node.each do |nom|
    book['Nominees'] << nom.at_css("img")['alt']
end

# description
book['Description'] = nokogiri.at_css('div#description').text.strip unless nokogiri.at_css('div#description').nil?
book['Description'] = nokogiri.at_css('div#descrption').text.strip unless nokogiri.at_css('div#descrption').nil?
book['Description'] = nokogiri.at_css('div#descrption span[style="display:none"]').text.strip unless nokogiri.at_css('div#descrption span[style="display:none"]').nil?
book['Description'] = nokogiri.at_css('div#description span[style="display:none"]').text.strip unless nokogiri.at_css('div#description span[style="display:none"]').nil?


# specify the collection where this record will be stored
book['_collection'] = 'books'

# save the product to the job’s outputs
outputs << book