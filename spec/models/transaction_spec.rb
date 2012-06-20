require 'spec_helper'

describe Transaction do
  describe ".occured_during" do
    it "should only return transactions that occured during specified period" do
      t1 = Transaction.new(operation_date: "2012-02-19")
      t1.save(validate: false)
      t2 = Transaction.new(operation_date: "2012-02-20")
      t2.save(validate: false)

      Transaction.occured_during("2012-01-01".to_date.."2012-01-31".to_date).should eq([])
      Transaction.occured_during("2012-02-01".to_date.."2012-02-29".to_date).should include(t1, t2)
      Transaction.occured_during("2012-02-01".to_date.."2012-02-19".to_date).should include(t1)
      Transaction.occured_during("2012-02-20".to_date.."2012-03-31".to_date).should include(t2)
      Transaction.occured_during("2012-03-01".to_date.."2012-03-31".to_date).should eq([])
    end
  end
end
