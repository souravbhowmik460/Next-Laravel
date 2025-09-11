<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateCardRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        // Reuse same validation rules as StoreCardRequest
        return (new StoreCardRequest())->rules();
    }

    public function messages(): array
    {
        // Reuse same messages
        return (new StoreCardRequest())->messages();
    }
}
