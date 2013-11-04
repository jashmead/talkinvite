require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe FaqsController do

  # This should return the minimal set of attributes required to create a valid
  # Faq. As you add validations to Faq, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "question" => "MyQuestion", "answer" => "MyAnswer" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # FaqsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all faqs as @faqs" do
      faq = Faq.create! valid_attributes
      get :index, {}, valid_session
      assigns(:faqs).should eq([faq])
    end
  end

  describe "GET show" do
    it "assigns the requested faq as @faq" do
      faq = Faq.create! valid_attributes
      get :show, {:id => faq.to_param}, valid_session
      assigns(:faq).should eq(faq)
    end
  end

  describe "GET new" do
    it "assigns a new faq as @faq" do
      get :new, {}, valid_session
      assigns(:faq).should be_a_new(Faq)
    end
  end

  describe "GET edit" do
    it "assigns the requested faq as @faq" do
      faq = Faq.create! valid_attributes
      get :edit, {:id => faq.to_param}, valid_session
      assigns(:faq).should eq(faq)
    end
  end

  describe "POST create" do

    describe "with valid params" do

      it "creates a new Faq" do
        expect {
          post :create, {:faq => valid_attributes}, valid_session
        }.to change(Faq, :count).by(1)
      end

      it "assigns a newly created faq as @faq" do
        post :create, {:faq => valid_attributes}, valid_session
        assigns(:faq).should be_a(Faq)
        assigns(:faq).should be_persisted
      end

      it "redirects to the list of faqs" do
        post :create, {:faq => valid_attributes}, { :return_to => faqs_url }
        response.should redirect_to(faqs_url)
      end

    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved faq as @faq" do
        # Trigger the behavior that occurs when invalid params are submitted
        Faq.any_instance.stub(:save).and_return(false)
        post :create, {:faq => { "question" => "invalid value" }}, valid_session
        assigns(:faq).should be_a_new(Faq)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Faq.any_instance.stub(:save).and_return(false)
        post :create, {:faq => { "question" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:person) { FactoryGirl.create(:person) }
      before { sign_in person, no_capybara: true }

      it "updates the requested faq" do
        faq = Faq.create! valid_attributes
        # Assuming there are no other faqs in the database, this
        # specifies that the Faq created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Faq.any_instance.should_receive(:update).with({ "question" => "MyText" })
        put :update, {:id => faq.to_param, :faq => { "question" => "MyText" }}, valid_session
      end

      it "assigns the requested faq as @faq" do
        faq = Faq.create! valid_attributes
        put :update, {:id => faq.to_param, :faq => valid_attributes}, valid_session
        assigns(:faq).should eq(faq)
      end

      it "redirects to the list of faqs" do
        faq = Faq.create! valid_attributes
        put :update, {:id => faq.to_param, :faq => valid_attributes}, { :return_to => faqs_url }
        response.should redirect_to(faqs_url)
      end

    end

    describe "with invalid params" do
      it "assigns the faq as @faq" do
        faq = Faq.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Faq.any_instance.stub(:save).and_return(false)
        put :update, {:id => faq.to_param, :faq => { "question" => "invalid value" }}, valid_session
        assigns(:faq).should eq(faq)
      end

      it "re-renders the 'edit' template" do
        faq = Faq.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Faq.any_instance.stub(:save).and_return(false)
        put :update, {:id => faq.to_param, :faq => { "question" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested faq" do
      faq = Faq.create! valid_attributes
      expect {
        delete :destroy, {:id => faq.to_param}, valid_session
      }.to change(Faq, :count).by(-1)
    end

    it "redirects to the faqs list" do
      faq = Faq.create! valid_attributes
      delete :destroy, {:id => faq.to_param}, valid_session
      response.should redirect_to(faqs_url)
    end
  end

end
