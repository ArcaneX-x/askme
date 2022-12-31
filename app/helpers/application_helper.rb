# frozen_string_literal: true

module ApplicationHelper
  def user_avatar(user)
    if user.avatar.present?
      user.avatar
    else
      asset_path 'default.png'
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
