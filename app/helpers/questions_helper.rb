module QuestionsHelper
  def without_tags(text)
    text.gsub(Hashtag::REGEXP_H, "")
  end
end
