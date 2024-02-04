module TestSelectorFinders
    def test_selector(value)
      "[#{Capybara.test_id.to_s.kebabcase}=\"#{value}\"]"
    end

    def find_test_selector(value)
        find(test_selector(value))
    end

    def within_test_selector(value, &block)
        within(test_selector(value), &block)
    end
end
    
RSpec.configure do |config|
    Capybara::Session.include(TestSelectorFinders)
    Capybara::DSL.extend(TestSelectorFinders)
    config.include TestSelectorFinders, type: :system
end