# clients/_portal
list :service_requests
    show service_request.service_quotes
    link service_request.service_providers
cta "I need sth else"
cta "I can do sth"

# service_providers/_portal
list :service_quotes
cta "look for service_requests" => service_requests_list
list :service_offers
    link service_offer.service.service_requests
cta "I can offer sth else"

# log_in

log_in.form
link_to sign_up

# index

if user_auth
    if user.has_no_pending_offers_or_quotes
        cta "I need sth" > new_service_request
        cta "I can do sth" > new_service_provider
    else   
        :portal
    end 
else
    cta "I need sth"
    cta "I can do sth"
end

# new_service_request

service_request.form
on_submit do
    if user_auth
        redirect_to log_in
    else
        list :service_providers.offering_service_request_service
        redirect_to :portal, "I will wait for quotes"
        redirect_to :portal, "I have other needs"
    end
end

# new_service_provodier

service_provider.form
if user_auth 
    redirect_to :service_provider_portal
else
    redirect_to :sign_up_as_service_provider
end

# service_provider/quote

show :service_request
service_quote.form
on_submit do 
    redirect_to list_services(service_request.service)
end