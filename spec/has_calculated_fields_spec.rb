require "spec_helper"
require "byebug"

describe HasCalculatedFields do
  describe "runs before_save callbacks" do
    let(:name) { "name" }
    let(:created_at) { Time.find_zone("Madrid").parse("2019-05-03 2pm") }
    let(:obj) { SampleModel.create(created_at: created_at, name: name) }

    context "using time" do
      context "when attribute has value" do
        it "assigns formatted time attribute" do
          new_date = Time.find_zone("Madrid").parse("2019-05-04 4pm")

          obj.created_at = new_date
          expect { obj.save }.to change { obj.calculated_created_at }
            .from("Fri, 03 May 2019 14:00:00 +0200")
            .to("Sat, 04 May 2019 16:00:00 +0200")
        end
      end
    end

    context "using method" do
      it "assigns new value to the calculated attribute" do
        obj.name = "new name"

        expect { obj.save }.to change { obj.calculated_name }
          .from("name calculated!")
          .to("new name calculated!")
      end

      it "assigns conditional when condition is matched" do
        obj.name = "conditional name"
        obj.random_attribute = "4"

        expect { obj.save }.to change {
          obj.calculated_conditional_unless
        }.and change { obj.calculated_conditional_if }
          .to("conditional name calculated!")
      end

      it "assigns conditional when condition is matched" do
        obj.name = "conditional name"

        expect { obj.save }.to change {
          obj.calculated_conditional_if
        }.and change { obj.calculated_conditional_unless }
          .to("conditional name calculated!")
      end
    end
  end
end
