require 'rails_helper'

describe AccomodationHelper do

    it 'correctly humanizes strings' do
        expect(humanize_enums([
            [:enum_name, 0],
            [:another_enum, 1],
        ])).to eq([
            ['Enum name', 0],
            ['Another enum', 1],
        ])
    end

end
