module QuestionsHelper
  def text_with_hashtag_link(text)
    text.gsub(Hashtag::REGEXP_H).each do |ht|
      link_to ht, hashtag_path(Hashtag.find_by(name: ht.delete("#")))
    end.html_safe
  end
end















