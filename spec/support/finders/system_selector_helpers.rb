module SystemSelectorHelpers
    def have_link_to(href)
        have_link('', href: href)
    end

    def click_link_to(href)
        click_link('', href: href)
    end

    def find_submit_button(form_action)
        button = find('.form[action="' + form_action.to_s + '"]').find('input[name="commit"]')
    end

end

RSpec.configure do |config|
    Capybara::Session.include(SystemSelectorHelpers)
    Capybara::DSL.extend(SystemSelectorHelpers)
    config.include SystemSelectorHelpers, type: :system
end
