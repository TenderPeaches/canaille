class String
    # for now only works with :symbols.to_s, because haven't had any other use case
    # todo find proper, more general function with regexes and stuff
    def kebabcase
        self.downcase.dasherize
    end
end