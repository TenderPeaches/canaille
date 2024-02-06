module FormHelpers
    def submit_button(form, instance)
        if instance.new_record?
            form.submit I18n.t('models.create')
        else
            form.submit I18n.t('models.update')
        end
    end
end