from django.shortcuts import render

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.mixins import UpdateModelMixin, DestroyModelMixin

from .models import Covidstatus
from .models import Location
from .models import Risk
from .models import People
from .models import Workstatus
from .models import Peopleworkstatus
from .models import Peopledetail

from .serializers import CovidstatusSerializer
from .serializers import LocationSerializer
from .serializers import RiskSerializer
from .serializers import PeopleSerializer
from .serializers import WorkstatusSerializer
from .serializers import PeopleworkstatusSerializer
from .serializers import PeopledetailSerializer

"""

FIELDS NEEDED
-------------
People [X]
People in a location
People who have Covid
People in a location who have Covid

"""

# Create your views here.
class PeopleView(APIView, UpdateModelMixin, DestroyModelMixin):
    def get(self, request, id=None, detailed='false'):
        if detailed == 'true':
            queryset = Peopledetail.objects.all()
            read_serializer = PeopledetailSerializer(queryset, many=True)
        elif id:
            try:
                queryset = People.objects.get(people_id=id)
            except People.DoesNotExist:
                return Response({'errors': 'This person item does not exist.'}, status=400)

            read_serializer = PeopleSerializer(queryset)
        else:
            queryset = People.objects.all()
            read_serializer = PeopleSerializer(queryset, many=True)

        return Response(read_serializer.data)

    def post(self, request):
        create_serializer = PeopleSerializer(data=request.data)

        if create_serializer.is_valid():
            person_item_object = create_serializer.save()
            read_serializer = PeopleSerializer(person_item_object)
        
            return Response(read_serializer.data, status=201)

        return Response(create_serializer.errors, status=400)
    
    def put(self, request, id=None):
        try:
            person_item = People.objects.get(id=id)
        except People.DoesNotExist:
            return Response({'errors': 'This person item does not exist.'}, status=400)
        
        update_serializer = PeopleSerializer(person_item, data=request.data)

        if update_serializer.is_valid():
            person_item_object = update_serializer.save()
            read_serializer = PeopleSerializer(person_item_object)

            return Response(read_serializer.data, status=200)
        
        return Response(update_serializer.errors, status=400)

    def delete(self, request, id=None):
        try:
            person_item = People.objects.get(id=id)
        except People.DoesNotExist:
            return Response({'errors': 'This person item does not exist.'}, status=400)

        person_item.delete()

        return Response(status=204)