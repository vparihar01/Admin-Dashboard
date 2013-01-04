ActiveAdmin.register Post do

  form do |f|
    f.inputs "User Details" do
      f.input :title
      f.input :content
      f.input :created_at
    end
    f.buttons
  end

  create_or_edit = Proc.new {
    @user            = Post.find_or_create_by_id(params[:id])

    if @user.save
      redirect_to :action => :show, :id => @user.id
    else
      render active_admin_template((@user.new_record? ? 'new' : 'edit') + '.html.erb')
    end
  }
  member_action :create, :method => :post, &create_or_edit
  member_action :update, :method => :put, &create_or_edit

end