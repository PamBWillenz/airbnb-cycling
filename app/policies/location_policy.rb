class LocationPolicy < ApplicationPolicy  

  def index?
    @member
  end

  def show?
    @member
  end

  def new?
    @member
  end

  def create?
    @member
  end

  def update?
    @member && @record.member == @member
  end

  def edit?
    @member && @record.member == @member
  end

  def destroy?
    @member && @record.member == @member
  end
end
