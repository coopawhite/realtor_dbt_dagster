from setuptools import find_packages, setup

setup(
    name="realtor_dagster_dbt",
    packages=find_packages(exclude=["realtor_dagster_dbt_tests"]),
    install_requires=[
        "dagster",
        "dagster-cloud"
    ],
    extras_require={"dev": ["dagster-webserver", "pytest"]},
)
