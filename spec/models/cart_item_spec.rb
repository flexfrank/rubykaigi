# -*- coding: utf-8 -*-
require 'spec_helper'

describe CartItem do
  before(:all) do
    @product = ProductItem.make(:unit_price => 1000)
  end

  context "when single item" do
    before(:all) do
      @cart_item = CartItem.new(@product)
    end

    subject { @cart_item }
    its(:subtotal_price) { should == 1000 }
    its(:unit_price) { should == 1000 }
    its(:quantity) { should == 1 }
    its(:item_code) { should == @product.item_code }
  end

  context "when multiple item" do
    before(:all) do
      @cart_item = CartItem.new(@product)
      @cart_item.increment_quantity
    end

    subject { @cart_item }
    its(:subtotal_price) { should == 2000 }
    its(:unit_price) { should == 1000 }
    its(:quantity) { should == 2 }
  end

  describe "#subtotal_price" do
    before(:all) do
      @cart_item = CartItem.new(@product)
      @cart_item.additional_amount = 2000
    end

    subject { @cart_item }
    its(:subtotal_price) { should == 3000 }
    its(:unit_price) { should == 1000 }
    its(:price) { should == 3000 }
    its(:quantity) { should == 1 }

    specify "商品の価格には影響していないこと" do
      @product.unit_price.should == 1000
    end
  end
end
