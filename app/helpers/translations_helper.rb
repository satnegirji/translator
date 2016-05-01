module TranslationsHelper
  def dynamic_word_field(form, name, options = {})
    #TODO fix this
    content_tag :div, {class: "searchable_wrap", val: name } do
      text_field_tag("#{name}[body]", "", { class: "searchable" }) +
      select_tag("#{name}[language_id]", options_for_select(languages_for_select)) +
      select_tag("#{name}[word_class_id]", options_for_select(word_classes_for_select)) +
      hidden_field_tag("#{name}[create_new]", false) +
      hidden_field_tag("#{name}[word_id]", "")

    end
  end
end
