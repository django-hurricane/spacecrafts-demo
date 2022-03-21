from django.apps import AppConfig


class ComponentsConfig(AppConfig):
    default_auto_field = "django.db.models.BigAutoField"
    name = "apps.components"

    def ready(self):
        from django.core.checks import register

        from apps.components.checks import example_check_main_engine

        register(example_check_main_engine, "hurricane")
