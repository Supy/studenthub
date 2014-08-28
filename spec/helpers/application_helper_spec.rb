require 'rails_helper'

describe ApplicationHelper do
    it 'correctly humanizes strings' do
        expect(humanize_enums([
            [:enum_name, 0],
            [:another_enum, 1],
        ])).to eq([
            ['Enum name', :enum_name],
            ['Another enum', :another_enum],
        ])
    end
end
