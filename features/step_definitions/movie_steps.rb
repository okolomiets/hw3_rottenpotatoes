# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(:title => movie['title'], :release_date => movie['release_date'], :rating => movie['rating'])
  end
  #flunk "Unimplemented"
end

When /^(?:|I )check the following ratings: (.*)/ do |rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  @checked_ratings = rating_list
  rating_list.split(%r{,\s*}).each do |field|
    check("ratings_"+field)
  end
end

When /^(?:|I )uncheck all other ratings/ do
  all_ratings = Movie.all_ratings
  all_ratings.each do |field|
    if !@checked_ratings.split(%r{,\s*}).include?(field)
      uncheck("ratings_"+field)
    end
  end
end

When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button(button)
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  html_body = page.body
  titles = html_body.scan(%r{<tr>[\D]{1}<td>(.*)</td>})
  a = []
  titles.each do |title|
    title.each do |element|
      a.push(element)
    end
  end
  assert a.index(e1) < a.index(e2)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

Then /^(?:|I )should see following movies: "(.*)"/ do |rating_list|
  html_body = page.body
  rows = html_body.scan(%r{<td>.*?</td>})
  @arr=[]
  rows.each do |row|
    row.scan(%r{<td>(.*?)</td>}).each do |value|
      @arr += value 
    end
  end
  rating_list.split(%r{,\s*}).each do |rating|
    assert @arr.include?(rating)
  end
end

# https://www.ruby-forum.com/topic/87845 - parsing html table cells

Then /unchecked movies are not visible/ do 
  other_ratings = Movie.all_ratings - @checked_ratings.split(%r{,\s*})
  other_ratings.each do |rating|
    assert !@arr.include?(rating)  
  end
end

When /^(?:|I )uncheck all ratings/ do
  all_ratings = Movie.all_ratings
  all_ratings.each do |rating|
    uncheck("ratings_"+rating)      
  end
end

When /^(?:|I )check all ratings/ do
  all_ratings = Movie.all_ratings
  all_ratings.each do |rating|
    check("ratings_"+rating)      
  end
end

Then /I should see all of the movies/ do 
  html_body = page.body
  rows = html_body.scan(%r{<td>([\w]{1,2}-?[\w]?{1,2})</td>})
  rows.size.should == Movie.all.size
end



