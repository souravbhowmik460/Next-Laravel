<?php
namespace App\Services;

use App\Models\Card;

class CardService
{
    public function getCardsByUser($userId)
    {
        return Card::where('user_id', $userId)
            ->orderBy('updated_at', 'desc')
            ->get();
    }

    public function createCard($user, array $payload)
    {
        return Card::create([
            'user_id' => $user->id,
            'profile' => $payload['profile'] ?? [
                'firstName' => '',
                'lastName' => '',
                'photo' => '',
                'designation' => '',
                'phone' => '',
                'email' => ''
            ],
            'business' => $payload['business'] ?? ['company' => '', 'role' => '', 'services' => []],
            'social' => $payload['social'] ?? ['linkedin'=>'','twitter'=>'','instagram'=>'','facebook'=>'','website'=>''],
            'about' => $payload['about'] ?? ['bio'=>'','experience'=>''],
            'cta' => $payload['cta'] ?? ['call'=>'','whatsapp'=>'','email'=>'','website'=>''],
        ]);
    }

    public function updateCard($user, $cardId, array $payload)
    {
        $card = Card::where('id', $cardId)
            ->where('user_id', $user->id)
            ->firstOrFail();

        $card->profile = array_merge($card->profile ?? [], $payload['profile'] ?? []);
        $card->business = array_merge($card->business ?? [], $payload['business'] ?? []);
        $card->social = array_merge($card->social ?? [], $payload['social'] ?? []);
        $card->about = array_merge($card->about ?? [], $payload['about'] ?? []);
        $card->cta = array_merge($card->cta ?? [], $payload['cta'] ?? []);
        $card->save();

        return $card;
    }

    public function deleteCard($user, Card $card)
    {
        if ($card->user_id !== $user->id) {
            abort(403, 'Unauthorized');
        }
        $card->delete();
        return true;
    }
}
