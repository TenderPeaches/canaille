module ServicesHelper
    def service_picker(form)
        form.collection_select :service_id, Service.all, :id, :label
    end
end
