module Jext
  class Extension
    include Model
    include Her::Model
    uses_api Jext.api
    has_one    :extension
    belongs_to :extension
  end
end
