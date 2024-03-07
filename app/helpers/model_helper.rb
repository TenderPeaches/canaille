module ModelHelper
    # base_path: the model's CRUD base path as an URL string
    def model_edit_delete_actions(base_path)
        [
            # edit model button
            model_edit_action(base_path),
            # delete model button
            model_delete_action(base_path)
        ].join('').html_safe
    end

    def model_edit_action(base_path)
        #! maybe there's a safer way to do the route but this works as long as rails routing naming conventions hold
        turbo_link_button(t('keywords.edit'), "#{base_path}/edit")
    end

    def model_delete_action(base_path)
        turbo_link_button(t('keywords.delete'), base_path)
    end
end
