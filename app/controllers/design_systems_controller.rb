class DesignSystemsController < ApplicationController
    def index
        @design_system = OpenStruct.new(
            font_sizes: ['xs', 's', 'm', 'l', 'xl', 'xxl', 'xxxl', 'xxxxl'],
            sizes: ['xxxs', 'xxs', 'xs', 's', 'm', 'l', 'xl', 'xxl', 'xxxl'],
            colors: ['primary', 'secondary', 'accent'], 
            color_tints: ['white', 'lightest', 'lighter', 'light', '', 'dark', 'darker', 'darkest', 'black']
        )
    end
end
