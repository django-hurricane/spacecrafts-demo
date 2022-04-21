import logging

from django.core.checks import Error

from apps.components.models import Component

logger = logging.getLogger("hurricane")


def example_check_main_engine(app_configs=None, **kwargs):
    """
    Check for existence of the "Main engine" component in the database
    """

    # your check logic here
    errors = []
    logger.info("Our check has been called :]")
    if not Component.objects.filter(title="Main engine").exists():
        errors.append(
            Error(
                "an error",
                hint="There is no main engine in the spacecraft, it need's to exist with the name 'Main engine'. "
                "Please create it in the admin or by installing the fixture.",
                id="components.E001",
            )
        )

    return errors
