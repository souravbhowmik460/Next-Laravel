<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreCardRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
        // accept nested JSON sections; each field optional
        'profile' => 'array',
        'profile.firstName' => 'nullable|string|max:100',
        'profile.lastName' => 'nullable|string|max:100',
        'profile.email' => 'nullable|email',
        'profile.phone' => ['nullable','regex:/^\+?[0-9\-\s]{7,20}$/'],
        'business' => 'array',
        'social' => 'array',
        'about' => 'array',
        'cta' => 'array',
    ];
    }
}
