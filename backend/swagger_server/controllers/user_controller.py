import imp
import connexion
import six

from swagger_server.models.error_response import ErrorResponse  # noqa: E501
from swagger_server.models.success_response import SuccessResponse  # noqa: E501
from swagger_server.models.user_login import UserLogin  # noqa: E501
from swagger_server import util

from swagger_server.dao import user_dao


def login_user(auth):  # noqa: E501
    """Logs user into the system

     # noqa: E501

    :param auth: Pet object that needs to be added to the store
    :type auth: dict | bytes

    :rtype: object
    """
    if connexion.request.is_json:
        auth = UserLogin.from_dict(connexion.request.get_json())  # noqa: E501
    
    user_dao.connect_db()
    return 'do some magic!'


def logout_user():  # noqa: E501
    """Logs out current logged in user session

     # noqa: E501


    :rtype: SuccessResponse
    """
    return 'do some magic!'
