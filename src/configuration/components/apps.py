from typing import Tuple

from decouple import config

INSTALLED_APPS: Tuple[str, ...] = (
    # Default django apps:
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    # django-admin:
    "django.contrib.admin",
    "django.contrib.admindocs",
    # Hurricane for Kubernetes integration:
    "hurricane",
    # Extensions and 3rd Party Apps:
    "django_extensions",
    "graphene_django",
    # Your Apps:
    "apps.components.apps.ComponentsConfig",
)

if config("INCLUDE_DEBUG_TOOLBAR", cast=bool, default=False):
    INSTALLED_APPS += ("debug_toolbar",)
