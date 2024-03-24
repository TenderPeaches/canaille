module TurboStreamActionsHelper
    def update_input(target, value)
        turbo_stream_action_tag :update_input, target: target, text: value
    end

    # show + enable
    def activate_inputs(targets)
        turbo_stream_action_tag :activate_inputs, targets: targets
    end

    # hide + disable
    def deactivate_inputs(targets)
        turbo_stream_action_tag :deactivate_inputs, targets: targets
    end

    # show
    def show(target)
        turbo_stream_action_tag :show, target: target
    end

    # hide
    def hide(target)
        turbo_stream_action_tag :hide, target: target
    end
end

Turbo::Streams::TagBuilder.prepend(TurboStreamActionsHelper)
