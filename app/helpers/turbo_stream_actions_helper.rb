module TurboStreamActionsHelper
    def update_input(target, value)
        turbo_stream_action_tag :update_input, target: target, text: value
    end
end

Turbo::Streams::TagBuilder.prepend(TurboStreamActionsHelper)
