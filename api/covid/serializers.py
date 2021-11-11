from rest_framework import serializers

from .models import Citycount, Countrycount, Covidstatus, Provincecount
from .models import Location
from .models import Risk
from .models import People
from .models import Workstatus
from .models import Peopleworkstatus
from .models import Peopledetail

"""
Serializers make sure that grabbed data matches the schema
"""

class CovidstatusSerializer(serializers.ModelSerializer):
    class Meta:
        model = Covidstatus
        fields = ('status_id', 'has_covid', 'prev_test', 'test_negative', 'test_inconcls')

class LocationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Location
        fields = ('location_id', 'country', 'state_province', 'city')

class RiskSerializer(serializers.ModelSerializer):
    class Meta:
        model = Risk
        fields = ('risk_id', 'risk_level', 'im_comp')

class PeopleSerializer(serializers.ModelSerializer):
    class Meta:
        model = People
        fields = ('people_id', 'risk', 'status', 'first_name', 'last_name', 'age', 'gender', 'email')

    def create(self, validated_data):
        risk, status, first_name, last_name, age, gender, email =\
            validated_data['risk'],\
            validated_data['status'],\
            validated_data['first_name'],\
            validated_data['last_name'],\
            validated_data['age'],\
            validated_data['gender'],\
            validated_data['email']

        instance = self.Meta.model(**validated_data)
        
        if risk and status and first_name and last_name and age and gender and email:
            instance.save()

        return instance

    def update(self, instance, validated_data):
        new_gender = validated_data.pop('gender', None)

        if new_gender:
            instance.gender = new_gender

        instance.save()
        return instance

class WorkstatusSerializer(serializers.ModelSerializer):
    class Meta:
        model = Workstatus
        fields = ('work_id', 'location', 'work_type', 'high_inter', 'hrs_inter')

class PeopleworkstatusSerializer(serializers.ModelSerializer):
    class Meta:
        model = Peopleworkstatus
        fields = ('people', 'work')

    def create(self, validated_data):
        people, work =\
            validated_data['people'],\
            validated_data['work']

        instance = self.Meta.model(**validated_data)

        if people and work:
            instance.save()

        return instance

    def update(self, instance, validated_data):
        new_work = validated_data.pop('work', None)

        if new_work:
            instance.work = new_work

        instance.save()
        return instance

class PeopledetailSerializer(serializers.ModelSerializer):
    class Meta:
        model = Peopledetail
        fields = ('people_id', 'first_name', 'last_name', 'has_covid', 'age', 'gender', 'email', 'country', 'state_province', 'city')

    def create(self, validated_data):
        return Peopledetail.objects.create(
            first_name = validated_data['first_name'],
            last_name = validated_data['last_name'],
            has_covid = validated_data['has_covid'],
            age = validated_data['age'],
            gender = validated_data['gender'],
            email = validated_data['email'],
            country = validated_data['country'],
            state_province = validated_data['state_province'],
            city = validated_data['city']
        )
    
    def update(self, instance, validated_data):
        return super().update(instance, validated_data)

class CitycountSerializer(serializers.ModelSerializer):
    class Meta:
        model = Citycount
        fields = ('city', 'cases')

class ProvincecountSerializer(serializers.ModelSerializer):
    class Meta:
        model = Provincecount
        fields = ('province', 'cases')

class CountrycountSerializer(serializers.ModelSerializer):
    class Meta:
        model = Countrycount
        fields = ('country', 'cases')