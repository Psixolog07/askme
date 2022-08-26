module ApplicationHelper
  def inclination(num , first_form , second_form, third_form)
    last_digit = num % 10
  
    if last_digit == 1 && num != 11
      first_form
    elsif last_digit.between?(2, 4) && !(num % 100).between?(12, 14)
      second_form
    else
      third_form
    end
  end

  def question_author(question)
    if question.author_id.present?
      author = User.find(question.author_id)
      link_to show_nickname(author), user_path(author.nickname)
    else
      "Anonymus"
    end
  end

  def question_owner(question)
    owner = User.find(question.user_id)
    link_to show_nickname(owner), user_path(owner.nickname)
  end

  def current_page_index?
    current_page?(controller: 'questions', action: 'index')
  end
end
