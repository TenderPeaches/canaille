module SystemSelectorHelpers
    def have_link_to(href)
        have_link('', href: href)
    end
end

RSpec.configure do |config|
    Capybara::Session.include(SystemSelectorHelpers)
    Capybara::DSL.extend(SystemSelectorHelpers)
    config.include SystemSelectorHelpers, type: :system
end