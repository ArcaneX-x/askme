# frozen_string_literal: true

module ApplicationHelper
  def user_avatar(user)
    if user.avatar?
      user.avatar.url
    else
      asset_path 'default_avatar.png'
    end
  end

  def question_author(question)
    if question.author.present?
      link_to "@#{question.author.username}", user_path(question.author)
    else
      'Noname'
    end
  end
end
