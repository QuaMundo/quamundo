# frozen_string_literal: true

# FIXME: Maybe split into separate files for better reuse?

# Provide regexp for a valid uuid and
# a example to check an object having a valid filled qm_uuid field
RSpec.configure do |_|
  RSpec::Matchers.define :be_an_uuid do |_|
    match do |actual_uuid|
      actual_uuid.match(/
        ^[a-f0-9]{8}
        -[a-f0-9]{4}
        -[a-f0-9]{4}
        -[a-f0-9]{4}
        -[a-f0-9]{12}$
        /x)
    end

    failure_message do |actual_uuid|
      "#{actual_uuid} does not match requirements of an uuid"
    end
  end
end

RSpec.shared_examples 'having an uuid' do |obj|
  let(:object) { create(obj) }

  it 'should have a valid uuid attached' do
    expect(object).to have_attribute(:qm_uuid)
    expect(object&.qm_uuid).to be_an_uuid
  end
end
