<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Card extends Model
{
    protected $fillable = ['user_id', 'profile', 'business', 'social', 'about', 'cta'];

    protected $casts = [
        'profile' => 'array',
        'business' => 'array',
        'social' => 'array',
        'about' => 'array',
        'cta' => 'array',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}
