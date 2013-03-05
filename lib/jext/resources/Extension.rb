module Jext
  class Extension
    include Her::Model
    uses_api Jext.api

    ## Associations
    has_one    :extension
    belongs_to :extension

    ##
    # Methods
    #

    def support_update_engine?(engines=[])
      return (engines & supported_update_engines).empty?
    end

    def parent?
      return self.parent
    end

    def child?
      return self.child
    end

    def secure?
      return self.secure
    end

    def support_updates?
      return self.support_updates
    end
  end
end
