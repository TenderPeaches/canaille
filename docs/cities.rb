# Cities - Used in coordinate forms, which are present in:

# ServiceRequest form (as client coordinates) =>
    "service_request[client_attributes][coordinate_attributes]"
# ServiceRequest form (as service request coordinates) =>
    "service_request[coordinate_attributes]"
# Client form
    "client[coordinate_attributes]"
# ServiceProvider form
    "service_provider[coordinate_attributes]"

# Whenever cities are set for a coordinate, the user has two choices: they use an existing city, or create one if their city doesn't exist yet. This is achieved through a checkbox (my city is not on the list)

# When the checkbox is clicked =>
    new_coordinate_choice(use_new_city: true)
# When the checkbox is unclicked/default state =>
    new_coordinate_choice(use_existing_city: true or use_new_city: false)

# In Coordinate.fields, how it is right now: =>
    content_tag :div, class: "form__group" do
        content_tag :div, class: "field field--postal-code" do
            form.label :postal_code, t('models.coordinate.postal_code')
            form.text_field :postal_code
        end
        content_tag :div, class: "field field--city", id: "city-select" do
            form.label :city_id, t('models.coordinate.city')
            form.collection_select :city_id, City.all, :id, :name
        end
    end
    content_tag :div, class: "form__checkbox" do
        form.check_box :use_new_city, { class: "use-new-city" }, 1, false
        form.label t('models.coordinate.use_new_city')
    end
    content_tag :div, class: "form__group", id: "city-form" do
    end

# what needs to happen =>
if :use_new_city
    hide "city-select"
    show "city-form"
if :use_existing_city
    hide "city-form"
    show "city-select"

# the hide/show cannot be at the CSS level only, it needs to happen so that the elements' values are passed along to the form when it is submitted

# this could be achieved through:
    # replacing the content completely
        #! this implies that the input form's name must be passed along somehow, as it is right now by having a :source argument sent alongside the request, which the server then interprets to return the correct input name
# OR
    # disabling/enabling + hiding/showing the relevant inputs
        # by using unique IDs (assuming never more than one city/coordinate form per page), the inputs can be disabled/hidden without having to re-create them, thus skipping the need to try and guess what form/input name is required
