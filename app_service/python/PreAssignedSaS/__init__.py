import logging
import os

import azure.functions as func


def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Pre-assigned SAS')
    logging.info(os.environ['SHARED_ACCESS_SIGNATURE'])       
    
    return func.HttpResponse(os.environ['SHARED_ACCESS_SIGNATURE'])

    # name = req.params.get('name')
    # if not name:
    #     try:
    #         req_body = req.get_json()
    #     except ValueError:
    #         pass
    #     else:
    #         name = req_body.get('name')

    # if name:
    #     return func.HttpResponse(f"Hello {name}!")
    # else:
    #     return func.HttpResponse(
    #          "Please pass a name on the query string or in the request body",
    #          status_code=400
    #     )
