module ServicesHelper
    def service_picker(form, selected_category = nil, selected_service = nil)
        # services come in many subcategories, better to use a custom picker
        render partial: "services/form_picker", locals: { service: selected_service, service_category: selected_category, form: form }
    end

    ##
    # service_category of which to choose from; if nil, show all services
    # selected service
    def service_picker_services_select(form, service_category: nil, selected_service: nil)
        # set services currently offered by the select's options
        services = get_picker_services(service_category, selected_service)

        if services.any?
            label = t('models.service.model_name')
        # if no services, must be an empty service category
        else
            label = t('feedback.service_category.no_services')
        end

        tag.label label
        # only show the select widget if there are any categories
        if services.any?
            form.collection_select :service_id, services, :id, :name, { selected: selected_service&.id || services.first }, { id: 'service-picker' }
        end
    end

    def service_picker_services_select_option(service_category = nil, selected_service = nil)
        if service_category
            category = service_category
        elsif selected_service
            category = selected_service.service_category
        end

        output = ""

        if category
            category.services.each do |service|
                output << tag.option(service.name, value: service.id)
            end
        end

        output.html_safe
    end

    private
    def get_picker_category(service_category = nil, service = nil)
        if service_category
            service_category
        else
            service&.service_category
        end
    end

    def get_picker_services(service_category = nil, service = nil)
        category = get_picker_category(service_category, service)

        if service_category || service
            category.services
        else
            Service.active
        end
    end
end
