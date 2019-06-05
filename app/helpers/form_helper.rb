module FormHelper
  def errors_for(model, attribute)
    if model.errors[attribute].present?
      content_tag :span, class: 'alert alert-danger' do
        model.errors[attribute].join(', ')
      end
    end
  end
end