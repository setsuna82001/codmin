module ContentsHelper
  def showparts key

    data = @content.send :names, "#{key}s".to_sym

    content_tag :div, (
      content_tag :div, "{{ #{key} }}"
    ), class: :row, 'ng-repeat' => "#{key} in #{data.to_json}"
  end
end
