<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreCardRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            // Profile section
            'profile' => 'array',
            'profile.firstName'   => 'nullable|string|max:100',
            'profile.lastName'    => 'nullable|string|max:100',
            'profile.email'       => 'nullable|email',
            'profile.phone'       => ['nullable','regex:/^\+?[0-9\-\s]{7,20}$/'],
            'profile.designation' => 'nullable|string|max:150',

            // Business section
            'business' => 'array',
            'business.company'  => 'nullable|string|max:150',
            'business.role'     => 'nullable|string|max:150',
            'business.services' => 'nullable|array',

            // Social section
            'social' => 'array',
            'social.linkedin'  => 'nullable|string|max:255',
            'social.twitter'   => 'nullable|string|max:255',
            'social.instagram' => 'nullable|string|max:255',
            'social.facebook'  => 'nullable|string|max:255',
            'social.website'   => 'nullable|url',

            // About section
            'about' => 'array',
            'about.bio'        => 'nullable|string',
            'about.experience' => 'nullable|string',

            // CTA section
            'cta' => 'array',
            'cta.call'     => 'nullable|string|max:20',
            'cta.whatsapp' => 'nullable|string|max:20',
            'cta.email'    => 'nullable|email',
            'cta.website'  => 'nullable|url',
        ];
    }

    public function messages(): array
    {
        return [
            'profile.firstName.max'   => 'First name must not exceed 100 characters.',
            'profile.lastName.max'    => 'Last name must not exceed 100 characters.',
            'profile.email.email'     => 'Please enter a valid email address.',
            'profile.phone.regex'     => 'Phone number must be valid (7–20 digits, may include +, -, or spaces).',
            'profile.designation.max' => 'Designation must not exceed 150 characters.',

            'business.company.max'    => 'Company name must not exceed 150 characters.',
            'business.role.max'       => 'Role must not exceed 150 characters.',
            'business.services.array' => 'Services must be provided as an array.',

            'social.linkedin.max'  => 'LinkedIn must not exceed 255 characters.',
            'social.twitter.max'   => 'Twitter must not exceed 255 characters.',
            'social.instagram.max' => 'Instagram must not exceed 255 characters.',
            'social.facebook.max'  => 'Facebook must not exceed 255 characters.',
            'social.website.url'   => 'Please enter a valid website URL.',

            'about.bio.string'        => 'Bio must be a text value.',
            'about.experience.string' => 'Experience must be a text value.',

            'cta.call.max'     => 'Call number must not exceed 20 characters.',
            'cta.whatsapp.max' => 'WhatsApp number must not exceed 20 characters.',
            'cta.email.email'  => 'Please enter a valid CTA email address.',
            'cta.website.url'  => 'CTA website must be a valid URL.',
        ];
    }
}
