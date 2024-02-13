module ServicesHelper
    def service_picker(form, selected = nil)
        # services come in many subcategories, better to use a custom picker 
        render partial: "services/form_picker", locals: { service: selected, form: form }
    end
end
