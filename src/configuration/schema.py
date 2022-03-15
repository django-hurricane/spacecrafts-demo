import graphene
from graphene_django import DjangoObjectType

from apps.components.models import Category, Component


class CategoryType(DjangoObjectType):
    class Meta:
        model = Category
        fields = ("id", "title")


class ComponentType(DjangoObjectType):
    class Meta:
        model = Component
        fields = ("id", "title", "description", "category")


class Query(graphene.ObjectType):
    all_components = graphene.List(ComponentType)
    category_by_name = graphene.Field(CategoryType, name=graphene.String(required=True))

    def resolve_all_components(root, info):
        return Component.objects.select_related("category").all()

    def resolve_category_by_name(root, info, name):
        try:
            return Category.objects.get(name=name)
        except Category.DoesNotExist:
            return None


schema = graphene.Schema(query=Query)
