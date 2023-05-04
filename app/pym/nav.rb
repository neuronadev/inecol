require 'modules/wizard.rb'
class Nav
    include Wizard
    
    def self.wizard_next(c,p)
        Acc::next_link
    end

    def self.wizard_back
        Acc::back_link
    end

end