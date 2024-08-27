output "lambda_func_get_arn" {
    value = aws_lambda_function.getapi.arn
}

output "lambda_func_get_qualified_arn" {
    value = aws_lambda_function.getapi.qualified_arn
}

output "lambda_func_get_invoke_arn" {
    value = aws_lambda_function.getapi.invoke_arn
}


output "lambda_func_get_version" {
    value = aws_lambda_function.getapi.version
}


output "lambda_func_get_last_modified" {
    value = aws_lambda_function.getapi.last_modified
}

output "lambda_func_get_kms_key_arn" {
    value = aws_lambda_function.getapi.kms_key_arn
}

output "lambda_func_get_signing_job_arn" {
    value = aws_lambda_function.getapi.signing_job_arn
}


output "lambda_func_get_signing_profile_version_arn" {
    value = aws_lambda_function.getapi.signing_profile_version_arn
}


output "lambda_func_get_source_code_hash" {
    value = aws_lambda_function.getapi.source_code_hash
}

output "lambda_func_get_source_code_size" {
    value = aws_lambda_function.getapi.source_code_size
}

#--------- POST Lambda--------

output "lambda_func_post_arn" {
    value = aws_lambda_function.postpushapi.arn
}

output "lambda_func_post_qualified_arn" {
    value = aws_lambda_function.postpushapi.qualified_arn
}

output "lambda_func_post_invoke_arn" {
    value = aws_lambda_function.postpushapi.invoke_arn
}


output "lambda_func_post_version" {
    value = aws_lambda_function.postpushapi.version
}


output "lambda_func_post_last_modified" {
    value = aws_lambda_function.postpushapi.last_modified
}

output "lambda_func_post_kms_key_arn" {
    value = aws_lambda_function.postpushapi.kms_key_arn
}

output "lambda_func_post_signing_job_arn" {
    value = aws_lambda_function.postpushapi.signing_job_arn
}


output "lambda_func_post_signing_profile_version_arn" {
    value = aws_lambda_function.getapi.signing_profile_version_arn
}


output "lambda_func_post_source_code_hash" {
    value = aws_lambda_function.getapi.source_code_hash
}

output "lambda_func_post_source_code_size" {
    value = aws_lambda_function.getapi.source_code_size
}


#  API GAteway Details-----------------

output "aws_api_gateway_rest_api_id" {
    value = aws_api_gateway_rest_api.api_gateway_name.id
}

# output "aws_api_gateway_rest_api_root_resource_id" {
#     value = aws_api_gateway_rest_api.api_gateway_name.resource_id
# }

output "aws_api_gateway_rest_api_created_date" {
    value = aws_api_gateway_rest_api.api_gateway_name.created_date
}

output "aws_api_gateway_rest_api_execution_arn" {
    value = aws_api_gateway_rest_api.api_gateway_name.execution_arn
}

output "aws_api_gateway_rest_api_arn" {
    value = aws_api_gateway_rest_api.api_gateway_name.arn
}

