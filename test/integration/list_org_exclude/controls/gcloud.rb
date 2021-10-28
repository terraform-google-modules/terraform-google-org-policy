# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Roles amount are used to test how the module behaves on configuration updates.
# Workaround InSpec lack of support for integer by parsing it from string.

project_id = attribute('project_id')
org_id = attribute('org_id')

control 'list-org-exclude' do
  title 'Test list exclude org policy is correct'

  describe command("gcloud beta resource-manager org-policies list --organization=#{org_id} --format=json") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq '' }

    let(:data) do
      if subject.exit_status == 0
        JSON.parse(subject.stdout).select{|x| x['constraint'] == 'constraints/compute.sharedReservationsOwnerProjects'}[0]
      else
        {}
      end
    end

    describe "list exclude org policy compute.sharedReservationsOwnerProjects"  do
      it "should exist" do
        expect(data).to_not be_empty
      end

      it "#{project_id} should be allowed" do
        expect(data['listPolicy']).to include(
          "allowedValues" => ["projects/#{project_id}"]
        )
      end
    end
  end
end
