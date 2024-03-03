module UsersHelper
    def user_service_provider_nav_label
        if current_user.user_service_provider_accesses.count == 1
            unless current_user.service_provider.name.empty?
                current_user.service_provider.name
            else
                "#{t('keywords.my_blank', mine: t('models.service_provider.model_name'))}"
            end
        else
            "#{t('keywords.my_blank', mine: t('models.service_provider.list_title'))}"
        end
    end
end
