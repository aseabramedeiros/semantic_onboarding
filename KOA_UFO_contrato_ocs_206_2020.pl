% ===== KOA Combined Output | contract_id: contrato_ocs_0206_2020 =====

% ===== 1) UFO Ontology =====
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE CONTRACT ONTOLOGY EM PROLOG
% Inspirada em UFO-L + UFO-S + Service Contract Ontology (Griffo et al., 2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% META-ESTRUTURA (TBox: classes, especializações, relações entre classes)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicados básicos de metamodelo
class(C).          % C é uma classe ontológica
subclass_of(C, P). % C é subclasse de P
disjoint(C1, C2).  % C1 e C2 são disjuntas conceitualmente

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Núcleo UFO-A / UFO-C simplificado
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(agent).           % agente (pessoa, organização etc.)
class(relator).         % relator genérico
class(moment).          % propriedade/momento (trope no sentido do UFO)

class(social_relator).
class(legal_relator).

subclass_of(social_relator, relator).
subclass_of(legal_relator, social_relator).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LEGAL MOMENTS E LEGAL RELATORS (UFO-L)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(legal_moment).
class(legal_entitlement).      % vantagens jurídicas
class(legal_burden_or_lack).  % ônus / falta de prerrogativa

subclass_of(legal_entitlement, legal_moment).
subclass_of(legal_burden_or_lack, legal_moment).

% Tipos de legal relators
class(simple_legal_relator).
class(complex_legal_relator).

subclass_of(simple_legal_relator, legal_relator).
subclass_of(complex_legal_relator, legal_relator).

% ---------------------------------------------------------------------------
% Right / Duty
% ---------------------------------------------------------------------------

class(right).
class(right_to_action).
class(right_to_omission).

class(duty).
class(duty_to_act).
class(duty_to_omit).

subclass_of(right, legal_entitlement).
subclass_of(right_to_action, right).
subclass_of(right_to_omission, right).

subclass_of(duty, legal_burden_or_lack).
subclass_of(duty_to_act, duty).
subclass_of(duty_to_omit, duty).

% ---------------------------------------------------------------------------
% NoRight / Permission
% ---------------------------------------------------------------------------

class(no_right).
class(no_right_to_action).
class(no_right_to_omission).

class(permission).
class(permission_to_act).
class(permission_to_omit).

subclass_of(no_right, legal_burden_or_lack).
subclass_of(no_right_to_action, no_right).
subclass_of(no_right_to_omission, no_right).

subclass_of(permission, legal_entitlement).
subclass_of(permission_to_act, permission).
subclass_of(permission_to_omit, permission).

% ---------------------------------------------------------------------------
% Power / Subjection (Liability)
% ---------------------------------------------------------------------------

class(power).
class(subjection).

subclass_of(power, legal_entitlement).
subclass_of(subjection, legal_burden_or_lack).

% ---------------------------------------------------------------------------
% Disability / Immunity
% ---------------------------------------------------------------------------

class(disability).
class(immunity).

subclass_of(disability, legal_burden_or_lack).
subclass_of(immunity, legal_entitlement).

% ---------------------------------------------------------------------------
% Liberty (liberdade desprotegida como complex legal relator)
% ---------------------------------------------------------------------------

class(liberty_relator).
subclass_of(liberty_relator, complex_legal_relator).

% ---------------------------------------------------------------------------
% Tipos de Simple Legal Relator (pares correlatos)
% ---------------------------------------------------------------------------

class(right_duty_relator).
class(noright_permission_relator).
class(power_subjection_relator).
class(disability_immunity_relator).

subclass_of(right_duty_relator, simple_legal_relator).
subclass_of(noright_permission_relator, simple_legal_relator).
subclass_of(power_subjection_relator, simple_legal_relator).
subclass_of(disability_immunity_relator, simple_legal_relator).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CORRELAÇÃO ENTRE LEGAL MOMENTS (Hohfeld + Alexy)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Correlatos em nível de classe
correlates(right_to_action,   duty_to_act).
correlates(duty_to_act,       right_to_action).

correlates(right_to_omission, duty_to_omit).
correlates(duty_to_omit,      right_to_omission).

correlates(permission_to_act,     no_right_to_action).
correlates(no_right_to_action,    permission_to_act).

correlates(permission_to_omit,    no_right_to_omission).
correlates(no_right_to_omission,  permission_to_omit).

correlates(power,      subjection).
correlates(subjection, power).

correlates(disability, immunity).
correlates(immunity,   disability).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE RELATIONS E SERVICE CONTRACTS (núcleo UFO-S simplificado)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(service_relation).
class(service_agreement).
class(legal_service_agreement).

subclass_of(service_agreement, service_relation).
subclass_of(legal_service_agreement, service_agreement).

% Papéis em relações de serviço
class(service_provider_role).
class(target_customer_role).
class(hired_service_provider_role).
class(service_customer_role).

subclass_of(hired_service_provider_role, service_provider_role).
subclass_of(service_customer_role,       target_customer_role).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE CONTRACT ONTOLOGY (Fig. 4 do artigo)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Em um Legal Service Agreement, cada parte tem Entitlements e Burdens/Lacks
class(hsp_entitlement).      % Hired Service Provider Entitlement
class(hsp_burden_or_lack).   % Hired Service Provider Burden/Lack
class(sc_entitlement).       % Service Customer Entitlement
class(sc_burden_or_lack).    % Service Customer Burden/Lack

subclass_of(hsp_entitlement, legal_entitlement).
subclass_of(sc_entitlement,  legal_entitlement).

subclass_of(hsp_burden_or_lack, legal_burden_or_lack).
subclass_of(sc_burden_or_lack,  legal_burden_or_lack).

% Composição: um Legal Service Agreement é composto de legal moments
% associados a cada papel (provider x customer).
relator_component(legal_service_agreement, hsp_entitlement).
relator_component(legal_service_agreement, hsp_burden_or_lack).
relator_component(legal_service_agreement, sc_entitlement).
relator_component(legal_service_agreement, sc_burden_or_lack).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESQUEMA PARA INSTÂNCIAS (ABox): AGENTES, ACORDOS, CLÁUSULAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% instance_of(Instancia, Classe).
% Você vai usar isso para criar indivíduos (contratos, cláusulas, agentes...).

:- dynamic instance_of/2.
:- dynamic plays_role/3.
:- dynamic legal_relation_instance/4.
:- dynamic clause_of/2.

% plays_role(Agente, Papel, Acordo).
% Ex.: plays_role(aws, hired_service_provider_role, aws_sns_agreement).
%      plays_role(cliente_x, service_customer_role, aws_sns_agreement).
plays_role(Agent, Role, Agreement).

% clause_of(ClauseId, Agreement).
% ClauseId é uma cláusula (ou grupo de cláusulas) de um acordo específico.
clause_of(ClauseId, Agreement).

% legal_relation_instance(ClauseId, LegalMoment, Bearer, Action).
%
% ClauseId   - identificador da cláusula
% LegalMoment- classe do momento jurídico (duty_to_omit, power, immunity...)
% Bearer     - quem tem esse momento (agente ou papel)
% Action     - ação/omissão ou descrição da conduta
%
% Exemplos (para você popular depois, inspirados no artigo):
% legal_relation_instance(clause_17_1, duty_to_omit, customer, share_service_with_third_parties).
% legal_relation_instance(clause_17_1, right_to_omission, provider, share_service_with_third_parties).

legal_relation_instance(ClauseId, LegalMomentClass, Bearer, Action) :-
    clause_of(ClauseId, _Agreement),
    class(LegalMomentClass),
    (   atom(Bearer)
    ;   plays_role(Bearer, _, _)
    ),
    atom(Action).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REGRAS AUXILIARES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fecho transitivo de subclass_of/2
subclass_of_trans(C, P) :-
    subclass_of(C, P).
subclass_of_trans(C, P) :-
    subclass_of(C, X),
    subclass_of_trans(X, P).

% is_a(Inst, Classe) — verifica se Inst é instância (direta ou indireta) de Classe
is_a(Inst, Classe) :-
    instance_of(Inst, C0),
    (   C0 = Classe
    ;   subclass_of_trans(C0, Classe)
    ).

% um legal_moment é um entitlement se a classe dele cai abaixo de legal_entitlement
is_entitlement(Inst) :-
    instance_of(Inst, C),
    subclass_of_trans(C, legal_entitlement).

% um legal_moment é um burden/lack se cai abaixo de legal_burden_or_lack
is_burden_or_lack(Inst) :-
    instance_of(Inst, C),
    subclass_of_trans(C, legal_burden_or_lack).

% Dado um LegalMomentClass, encontrar seu correlato (em termos de classe)
correlative_class(LMClass, CorrelateClass) :-
    correlates(LMClass, CorrelateClass).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIM DA ONTOLOGIA BASE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ===== 2) Generated UFO ABox =====
% UFO-only grounding generated from: KOA_Contrato_OCS_206_2020_-_BRy.pl
% contract_id: contrato_ocs_0206_2020

instance_of(contrato_ocs_0206_2020, legal_service_agreement).

instance_of(banco_nacional_de_desenvolvimento_economico_e_social_bndes, agent).
instance_of(bry_tecnologia_s_a, agent).

plays_role(banco_nacional_de_desenvolvimento_economico_e_social_bndes, service_customer_role, contrato_ocs_0206_2020).
plays_role(bry_tecnologia_s_a, hired_service_provider_role, contrato_ocs_0206_2020).

clause_of(clausula_primeira_objeto, contrato_ocs_0206_2020).
clause_of(clausula_segunda_vigencia, contrato_ocs_0206_2020).
clause_of(clausula_terceira_local_prazo_condicoes_execucao_objeto, contrato_ocs_0206_2020).
clause_of(clausula_quarta_niveis_servico, contrato_ocs_0206_2020).
clause_of(clausula_quinta_recebimento_objeto, contrato_ocs_0206_2020).
clause_of(clausula_sexta_preco, contrato_ocs_0206_2020).
clause_of(clausula_setima_pagamento, contrato_ocs_0206_2020).
clause_of(clausula_oitava_equilibrio_economico_financeiro_contrato, contrato_ocs_0206_2020).
clause_of(clausula_nona_matriz_riscos, contrato_ocs_0206_2020).
clause_of(clausula_decima_obrigacoes_contratada, contrato_ocs_0206_2020).
clause_of(clausula_decima_primeira_conduta_etica_contratada_bndes, contrato_ocs_0206_2020).
clause_of(clausula_decima_segunda_sigilo_informacoes, contrato_ocs_0206_2020).
clause_of(clausula_decima_terceira_obrigações_bndes, contrato_ocs_0206_2020).
clause_of(clausula_decima_quarta_cessao_contrato_credito_sucessao_contratual_subcontratação, contrato_ocs_0206_2020).
clause_of(clausula_decima_quinta_penalidades, contrato_ocs_0206_2020).
clause_of(clausula_decima_sexta_alterações_contratuais, contrato_ocs_0206_2020).
clause_of(clausula_decima_setima_extincao_do_contrato, contrato_ocs_0206_2020).
clause_of(clausula_decima_oitava_disposições_finais, contrato_ocs_0206_2020).
clause_of(clausula_decima_nona_foro, contrato_ocs_0206_2020).

legal_relation_instance(clausula_primeira_objeto, duty_to_act, bry_tecnologia_s_a, provide_time_stamping_service).
legal_relation_instance(clausula_primeira_objeto, right_to_action, bry_tecnologia_s_a, provide_time_stamping_service).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_time_stamping_service).
legal_relation_instance(clausula_segunda_vigencia, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, extend_contract_term).
legal_relation_instance(clausula_segunda_vigencia, no_right_to_action, unknown, unilateral_terminate_before_30_months).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, bry_tecnologia_s_a, execute_contract_according_to_specifications).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_execution_according_to_specifications).
legal_relation_instance(clausula_quarta_niveis_servico, duty_to_act, bry_tecnologia_s_a, execute_services_according_to_standards).
legal_relation_instance(clausula_quarta_niveis_servico, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_service_execution_per_standards).
legal_relation_instance(clausula_quinta_recebimento_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_object_receipt).
legal_relation_instance(clausula_quinta_recebimento_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_object_receipt).
legal_relation_instance(clausula_sexta_preco, duty_to_act, bry_tecnologia_s_a, bear_costs_of_sizing_error).
legal_relation_instance(clausula_sexta_preco, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pay_contracted_value).
legal_relation_instance(clausula_sexta_preco, subjection, bry_tecnologia_s_a, subject_to_reduced_payment).
legal_relation_instance(clausula_sexta_preco, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_full_object).
legal_relation_instance(clausula_sexta_preco, right_to_omission, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_payment_of_indemnization).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_payment).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, bry_tecnologia_s_a, ensure_fiscal_document_compliance).
legal_relation_instance(clausula_setima_pagamento, duty_to_omit, bry_tecnologia_s_a, not_emit_non_compliant_doc).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, bry_tecnologia_s_a, present_fiscal_document).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, bry_tecnologia_s_a, send_fiscal_document_by_email).
legal_relation_instance(clausula_setima_pagamento, right_to_action, bry_tecnologia_s_a, receive_payment).
legal_relation_instance(clausula_setima_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_fiscal_document).
legal_relation_instance(clausula_setima_pagamento, subjection, bry_tecnologia_s_a, iss_retention).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, request_economic_financial_rebalancing).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, bry_tecnologia_s_a, request_price_adjustment).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, bry_tecnologia_s_a, request_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, bry_tecnologia_s_a, submit_price_revision_request).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, bry_tecnologia_s_a, present_cost_info_on_bndes_request).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, call_contracted_to_negotiate_price_reduction).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_rebalancing_request).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_omit, bry_tecnologia_s_a, omit_celebration_of_addenda).
legal_relation_instance(clausula_nona_matriz_riscos, no_right_to_action, bry_tecnologia_s_a, no_right_to_celebrate_addenda).
legal_relation_instance(clausula_decima_obrigacoes_contratada, duty_to_act, bry_tecnologia_s_a, designar_preposto).
legal_relation_instance(clausula_decima_obrigacoes_contratada, duty_to_act, bry_tecnologia_s_a, comunicar_penalidade).
legal_relation_instance(clausula_decima_obrigacoes_contratada, duty_to_act, bry_tecnologia_s_a, reparar_objeto_contrato).
legal_relation_instance(clausula_decima_obrigacoes_contratada, duty_to_act, bry_tecnologia_s_a, reparar_danos_prejuizos).
legal_relation_instance(clausula_decima_obrigacoes_contratada, duty_to_act, bry_tecnologia_s_a, pagar_encargos_tributos).
legal_relation_instance(clausula_decima_obrigacoes_contratada, duty_to_omit, bry_tecnologia_s_a, nao_infringir_direitos_autorais).
legal_relation_instance(clausula_decima_obrigacoes_contratada, duty_to_omit, bry_tecnologia_s_a, manter_sigilo).
legal_relation_instance(clausula_decima_obrigacoes_contratada, duty_to_act, bry_tecnologia_s_a, descartar_informacoes_bndes).
legal_relation_instance(clausula_decima_obrigacoes_contratada, duty_to_act, bry_tecnologia_s_a, exportar_entregar_logs).
legal_relation_instance(clausula_decima_obrigacoes_contratada, subjection, bry_tecnologia_s_a, permitir_vistorias_gestor).
legal_relation_instance(clausula_decima_primeira_conduta_etica_contratada_bndes, duty_to_act, bry_tecnologia_s_a, maintain_integrity).
legal_relation_instance(clausula_decima_primeira_conduta_etica_contratada_bndes, duty_to_act, bry_tecnologia_s_a, act_in_good_faith).
legal_relation_instance(clausula_decima_primeira_conduta_etica_contratada_bndes, duty_to_omit, bry_tecnologia_s_a, not_offer_undue_advantage).
legal_relation_instance(clausula_decima_primeira_conduta_etica_contratada_bndes, duty_to_act, bry_tecnologia_s_a, prevent_corruption).
legal_relation_instance(clausula_decima_primeira_conduta_etica_contratada_bndes, duty_to_act, bry_tecnologia_s_a, prevent_favoritism).
legal_relation_instance(clausula_decima_primeira_conduta_etica_contratada_bndes, duty_to_act, bry_tecnologia_s_a, avoid_family_allocation).
legal_relation_instance(clausula_decima_primeira_conduta_etica_contratada_bndes, duty_to_act, bry_tecnologia_s_a, observe_bndes_ethics_code).
legal_relation_instance(clausula_decima_primeira_conduta_etica_contratada_bndes, duty_to_act, bry_tecnologia_s_a, adopt_sustainability_practices).
legal_relation_instance(clausula_decima_primeira_conduta_etica_contratada_bndes, duty_to_act, bry_tecnologia_s_a, remove_agents_immediately).
legal_relation_instance(clausula_decima_primeira_conduta_etica_contratada_bndes, duty_to_act, bry_tecnologia_s_a, communicate_fact_to_bndes).
legal_relation_instance(clausula_decima_segunda_sigilo_informacoes, duty_to_act, bry_tecnologia_s_a, maintain_confidentiality).
legal_relation_instance(clausula_decima_segunda_sigilo_informacoes, duty_to_act, bry_tecnologia_s_a, provide_signatures_on_confidentiality_terms).
legal_relation_instance(clausula_decima_segunda_sigilo_informacoes, duty_to_act, bry_tecnologia_s_a, orient_professionals_regarding_confidentiality).
legal_relation_instance(clausula_decima_segunda_sigilo_informacoes, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, request_signatures_on_confidentiality_terms).
legal_relation_instance(clausula_decima_segunda_sigilo_informacoes, subjection, bry_tecnologia_s_a, be_subject_to_signature_request_confidentiality_terms).
legal_relation_instance(clausula_decima_segunda_sigilo_informacoes, right_to_omission, unknown, omit_disclosing_information_before_request).
legal_relation_instance(clausula_decima_terceira_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, realizar_pagamentos_devidos).
legal_relation_instance(clausula_decima_terceira_obrigações_bndes, right_to_action, bry_tecnologia_s_a, receive_payments).
legal_relation_instance(clausula_decima_terceira_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designar_gestor_contrato).
legal_relation_instance(clausula_decima_terceira_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designar_gestor_substituto).
legal_relation_instance(clausula_decima_terceira_obrigações_bndes, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, alterar_gestor_contrato).
legal_relation_instance(clausula_decima_terceira_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, fornecer_codigo_etica).
legal_relation_instance(clausula_decima_terceira_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, colocar_disposicao_informacoes).
legal_relation_instance(clausula_decima_terceira_obrigações_bndes, right_to_action, bry_tecnologia_s_a, receive_necessary_information).
legal_relation_instance(clausula_decima_terceira_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, comunicar_instrucoes).
legal_relation_instance(clausula_decima_terceira_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, comunicar_abertura_procedimento).
legal_relation_instance(clausula_decima_quarta_cessao_contrato_credito_sucessao_contratual_subcontratação, duty_to_omit, bry_tecnologia_s_a, omit_contract_assignment).
legal_relation_instance(clausula_decima_quarta_cessao_contrato_credito_sucessao_contratual_subcontratação, no_right_to_action, bry_tecnologia_s_a, assign_contract).
legal_relation_instance(clausula_decima_quarta_cessao_contrato_credito_sucessao_contratual_subcontratação, duty_to_omit, bry_tecnologia_s_a, omit_credit_assignment).
legal_relation_instance(clausula_decima_quarta_cessao_contrato_credito_sucessao_contratual_subcontratação, no_right_to_action, bry_tecnologia_s_a, assign_credit).
legal_relation_instance(clausula_decima_quarta_cessao_contrato_credito_sucessao_contratual_subcontratação, duty_to_omit, bry_tecnologia_s_a, omit_issuing_credit_title).
legal_relation_instance(clausula_decima_quarta_cessao_contrato_credito_sucessao_contratual_subcontratação, no_right_to_action, bry_tecnologia_s_a, issue_credit_title).
legal_relation_instance(clausula_decima_quarta_cessao_contrato_credito_sucessao_contratual_subcontratação, duty_to_omit, bry_tecnologia_s_a, omit_subcontracting).
legal_relation_instance(clausula_decima_quarta_cessao_contrato_credito_sucessao_contratual_subcontratação, no_right_to_action, bry_tecnologia_s_a, subcontract).
legal_relation_instance(clausula_decima_quarta_cessao_contrato_credito_sucessao_contratual_subcontratação, duty_to_act, bry_tecnologia_s_a, maintain_contractual_conditions).
legal_relation_instance(clausula_decima_quarta_cessao_contrato_credito_sucessao_contratual_subcontratação, duty_to_omit, bry_tecnologia_s_a, omit_contractual_succession).
legal_relation_instance(clausula_decima_quinta_penalidades, subjection, bry_tecnologia_s_a, be_subject_to_penalties).
legal_relation_instance(clausula_decima_quinta_penalidades, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, ensure_due_process).
legal_relation_instance(clausula_decima_quinta_penalidades, right_to_action, bry_tecnologia_s_a, right_to_defense).
legal_relation_instance(clausula_decima_quinta_penalidades, right_to_action, bry_tecnologia_s_a, right_to_appeal).
legal_relation_instance(clausula_decima_quinta_penalidades, duty_to_omit, bry_tecnologia_s_a, omit_total_or_partial_non_performance).
legal_relation_instance(clausula_decima_quinta_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalties).
legal_relation_instance(clausula_decima_quinta_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract).
legal_relation_instance(clausula_decima_quinta_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_from_credits).
legal_relation_instance(clausula_decima_sexta_alterações_contratuais, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, alterar_contrato_acordo).
legal_relation_instance(clausula_decima_sexta_alterações_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, formalizar_alteracao_contratual).
legal_relation_instance(clausula_decima_sexta_alterações_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, responder_por_danos).
legal_relation_instance(clausula_decima_sexta_alterações_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, formalizar_alteracao_aditivo).
legal_relation_instance(clausula_decima_sexta_alterações_contratuais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, alegar_justo_motivo).
legal_relation_instance(clausula_decima_setima_extincao_do_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, notify_other_party).
legal_relation_instance(clausula_decima_setima_extincao_do_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_opportunity_for_defense).
legal_relation_instance(clausula_decima_setima_extincao_do_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, extinguish_contract).
legal_relation_instance(clausula_decima_setima_extincao_do_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, suspend_contract_execution).
legal_relation_instance(clausula_decima_setima_extincao_do_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_suspension).
legal_relation_instance(clausula_decima_oitava_disposições_finais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, exercise_rights_any_time).
legal_relation_instance(clausula_decima_oitava_disposições_finais, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, claim_waiver).
legal_relation_instance(clausula_decima_nona_foro, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, litigate_in_other_forum).
legal_relation_instance(clausula_decima_nona_foro, power, unknown, establish_forum).

% --- Action catalog (local to this contract grounding) ---
action_type(act_in_good_faith).
action_label(act_in_good_faith, 'act in good faith').
action_type(act_in_good_faith_bndes).
action_label(act_in_good_faith_bndes, 'act in good faith').
action_type(adopt_sustainability_practices).
action_label(adopt_sustainability_practices, 'adopt sustainability practices').
action_type(alegar_justo_motivo).
action_label(alegar_justo_motivo, 'Claim justified reason').
action_type(alterar_contrato_acordo).
action_label(alterar_contrato_acordo, 'Alter contract by agreement').
action_type(alterar_gestor_contrato).
action_label(alterar_gestor_contrato, 'Change contract manager').
action_type(analyze_contractual_risks).
action_label(analyze_contractual_risks, 'Analyze contractual risks').
action_type(analyze_rebalancing_request).
action_label(analyze_rebalancing_request, 'Analyze rebalancing request').
action_type(apply_penalties).
action_label(apply_penalties, 'Apply penalties').
action_type(assign_contract).
action_label(assign_contract, 'No right to assign contract').
action_type(assign_credit).
action_label(assign_credit, 'No right to assign credit').
action_type(atender_solicitacoes_transicao).
action_label(atender_solicitacoes_transicao, 'Meet transition requests').
action_type(avoid_family_allocation).
action_label(avoid_family_allocation, 'avoid family allocation').
action_type(be_subject_to_penalties).
action_label(be_subject_to_penalties, 'Be subject to penalties').
action_type(be_subject_to_signature_request_confidentiality_terms).
action_label(be_subject_to_signature_request_confidentiality_terms, 'Be subject to signature request').
action_type(bear_costs_of_sizing_error).
action_label(bear_costs_of_sizing_error, 'Bear costs of sizing error').
action_type(call_contracted_to_negotiate_price_reduction).
action_label(call_contracted_to_negotiate_price_reduction, 'Call contracted to negotiate price reduction').
action_type(claim_waiver).
action_label(claim_waiver, 'Claim waiver').
action_type(colocar_disposicao_informacoes).
action_label(colocar_disposicao_informacoes, 'Provide necessary info').
action_type(communicate_fact_to_bndes).
action_label(communicate_fact_to_bndes, 'communicate fact to BNDES').
action_type(comunicar_abertura_procedimento).
action_label(comunicar_abertura_procedimento, 'Communicate procedure opening').
action_type(comunicar_aplicacao_penalidade).
action_label(comunicar_aplicacao_penalidade, 'Communicate penalty').
action_type(comunicar_instrucoes).
action_label(comunicar_instrucoes, 'Communicate instructions').
action_type(comunicar_penalidade).
action_label(comunicar_penalidade, 'Report penalties').
action_type(contractual_succession).
action_label(contractual_succession, 'No right to contractual succession').
action_type(deduct_from_credits).
action_label(deduct_from_credits, 'Deduct from credits').
action_type(demand_execution_according_to_specifications).
action_label(demand_execution_according_to_specifications, 'Demand execution as specified').
action_type(demand_full_object).
action_label(demand_full_object, 'Demand full object').
action_type(demand_service_execution_per_standards).
action_label(demand_service_execution_per_standards, 'Demand service execution').
action_type(descartar_informacoes_bndes).
action_label(descartar_informacoes_bndes, 'Discard BNDES info').
action_type(designar_gestor_contrato).
action_label(designar_gestor_contrato, 'Designate contract manager').
action_type(designar_gestor_substituto).
action_label(designar_gestor_substituto, 'Designate substitute manager').
action_type(designar_preposto).
action_label(designar_preposto, 'Designate representative').
action_type(effect_object_receipt).
action_label(effect_object_receipt, 'Effect object receipt').
action_type(effect_payment).
action_label(effect_payment, 'Effect payment').
action_type(ensure_due_process).
action_label(ensure_due_process, 'Ensure due process').
action_type(ensure_fiscal_document_compliance).
action_label(ensure_fiscal_document_compliance, 'Ensure fiscal document compliance').
action_type(establish_forum).
action_label(establish_forum, 'Establish forum').
action_type(execute_contract_according_to_specifications).
action_label(execute_contract_according_to_specifications, 'Execute contract as specified').
action_type(execute_services_according_to_standards).
action_label(execute_services_according_to_standards, 'Execute services per standards').
action_type(exercise_rights_any_time).
action_label(exercise_rights_any_time, 'Exercise rights anytime').
action_type(exportar_entregar_logs).
action_label(exportar_entregar_logs, 'Export logs').
action_type(extend_contract_term).
action_label(extend_contract_term, 'Extend contract term').
action_type(extinguish_contract).
action_label(extinguish_contract, 'Extinguish contract').
action_type(formalizar_alteracao_aditivo).
action_label(formalizar_alteracao_aditivo, 'Formalize contract change by addendum').
action_type(formalizar_alteracao_contratual).
action_label(formalizar_alteracao_contratual, 'Formalize contract change').
action_type(fornecer_codigo_etica).
action_label(fornecer_codigo_etica, 'Provide code of ethics').
action_type(iss_retention).
action_label(iss_retention, 'Subjection to ISS retention').
action_type(issue_credit_title).
action_label(issue_credit_title, 'No right to issue credit title').
action_type(litigate_in_other_forum).
action_label(litigate_in_other_forum, 'No litigation in other forum').
action_type(maintain_confidentiality).
action_label(maintain_confidentiality, 'Maintain confidentiality').
action_type(maintain_contractual_conditions).
action_label(maintain_contractual_conditions, 'Maintain original conditions').
action_type(maintain_integrity).
action_label(maintain_integrity, 'maintain integrity').
action_type(maintain_integrity_bndes).
action_label(maintain_integrity_bndes, 'maintain integrity').
action_type(manter_sigilo).
action_label(manter_sigilo, 'Maintain confidentiality').
action_type(nao_infringir_direitos_autorais).
action_label(nao_infringir_direitos_autorais, 'Do not infringe copyright').
action_type(no_right_to_celebrate_addenda).
action_label(no_right_to_celebrate_addenda, 'No right to celebrate addenda').
action_type(not_emit_non_compliant_doc).
action_label(not_emit_non_compliant_doc, 'Not emit non compliant document').
action_type(not_offer_undue_advantage).
action_label(not_offer_undue_advantage, 'not offer undue advantage').
action_type(notify_other_party).
action_label(notify_other_party, 'Notify other party').
action_type(obedecer_instrucoes_bndes).
action_label(obedecer_instrucoes_bndes, 'Obey instructions').
action_type(observe_bndes_ethics_code).
action_label(observe_bndes_ethics_code, 'observe BNDES ethics code').
action_type(omit_celebration_of_addenda).
action_label(omit_celebration_of_addenda, 'Omit celebration of addenda').
action_type(omit_contract_assignment).
action_label(omit_contract_assignment, 'Omit contract assignment').
action_type(omit_contractual_succession).
action_label(omit_contractual_succession, 'Omit contractual succession').
action_type(omit_credit_assignment).
action_label(omit_credit_assignment, 'Omit credit assignment').
action_type(omit_disclosing_information_before_request).
action_label(omit_disclosing_information_before_request, 'Omit disclosing information before request').
action_type(omit_issuing_credit_title).
action_label(omit_issuing_credit_title, 'Omit issuing credit title').
action_type(omit_payment_of_indemnization).
action_label(omit_payment_of_indemnization, 'Omit payment of indemnization').
action_type(omit_subcontracting).
action_label(omit_subcontracting, 'Omit subcontracting').
action_type(omit_total_or_partial_non_performance).
action_label(omit_total_or_partial_non_performance, 'Omit total/partial non-performance').
action_type(orient_professionals_regarding_confidentiality).
action_label(orient_professionals_regarding_confidentiality, 'Orient professionals').
action_type(pagar_encargos_tributos).
action_label(pagar_encargos_tributos, 'Pay taxes and fees').
action_type(pay_contracted_value).
action_label(pay_contracted_value, 'Pay contracted value').
action_type(perform_contractual_succession).
action_label(perform_contractual_succession, 'Permitted contractual succession').
action_type(permitir_acesso_banco_central).
action_label(permitir_acesso_banco_central, 'Permit access to Central Bank').
action_type(permitir_vistorias_gestor).
action_label(permitir_vistorias_gestor, 'Subject to inspections').
action_type(present_cost_info_on_bndes_request).
action_label(present_cost_info_on_bndes_request, 'Present cost info on BNDES request').
action_type(present_fiscal_document).
action_label(present_fiscal_document, 'Present fiscal document').
action_type(prevent_corruption).
action_label(prevent_corruption, 'prevent corruption').
action_type(prevent_favoritism).
action_label(prevent_favoritism, 'prevent favoritism').
action_type(provide_opportunity_for_defense).
action_label(provide_opportunity_for_defense, 'Provide opportunity for defense').
action_type(provide_signatures_on_confidentiality_terms).
action_label(provide_signatures_on_confidentiality_terms, 'Provide confidentiality terms signatures').
action_type(provide_time_stamping_service).
action_label(provide_time_stamping_service, 'Provide time stamping service').
action_type(providenciar_exclusao_simples).
action_label(providenciar_exclusao_simples, 'Arrange Simples exclusion').
action_type(realizar_pagamentos_devidos).
action_label(realizar_pagamentos_devidos, 'Make payments to contracted party').
action_type(receive_fiscal_document).
action_label(receive_fiscal_document, 'Receive fiscal document').
action_type(receive_necessary_information).
action_label(receive_necessary_information, 'Receive necessary information').
action_type(receive_payment).
action_label(receive_payment, 'Receive Payment').
action_type(receive_payments).
action_label(receive_payments, 'Receive payments').
action_type(receive_time_stamping_service).
action_label(receive_time_stamping_service, 'Receive time stamping service').
action_type(remove_agents_immediately).
action_label(remove_agents_immediately, 'remove agents immediately').
action_type(reparar_danos_prejuizos).
action_label(reparar_danos_prejuizos, 'Repair damages').
action_type(reparar_objeto_contrato).
action_label(reparar_objeto_contrato, 'Repair contract object').
action_type(request_codigo_etica).
action_label(request_codigo_etica, 'Request code of ethics').
action_type(request_economic_financial_rebalancing).
action_label(request_economic_financial_rebalancing, 'Request economic-financial rebalancing').
action_type(request_price_adjustment).
action_label(request_price_adjustment, 'Request price adjustment').
action_type(request_price_revision).
action_label(request_price_revision, 'Request price revision').
action_type(request_signatures_on_confidentiality_terms).
action_label(request_signatures_on_confidentiality_terms, 'Request signatures').
action_type(responder_por_danos).
action_label(responder_por_danos, 'Answer for damages').
action_type(responsabilizar_normas_seguranca).
action_label(responsabilizar_normas_seguranca, 'Responsible security norms').
action_type(right_to_appeal).
action_label(right_to_appeal, 'Right to appeal').
action_type(right_to_defend).
action_label(right_to_defend, 'Right to defend').
action_type(right_to_defense).
action_label(right_to_defense, 'Right to defense').
action_type(send_fiscal_document_by_email).
action_label(send_fiscal_document_by_email, 'Send fiscal document by email').
action_type(subcontract).
action_label(subcontract, 'No right to subcontract').
action_type(subject_to_reduced_payment).
action_label(subject_to_reduced_payment, 'Subject to reduced payment').
action_type(submit_price_revision_request).
action_label(submit_price_revision_request, 'Submit price revision request').
action_type(suspend_contract_execution).
action_label(suspend_contract_execution, 'Suspend contract execution').
action_type(terminate_contract).
action_label(terminate_contract, 'Terminate contract').
action_type(terminate_contract_suspension).
action_label(terminate_contract_suspension, 'Terminate contract after suspension').
action_type(unilateral_terminate_before_30_months).
action_label(unilateral_terminate_before_30_months, 'No right to terminate before 30 months').

% ===== 3) Original Contract ABox =====
contract(contrato_ocs_0206_2020).
contract_metadata(contrato_ocs_0206_2020, numero_ocs, '0206/2020').
contract_metadata(contrato_ocs_0206_2020, numero_sap, '4400004362').
contract_metadata(contrato_ocs_0206_2020, tipo_contrato, 'CONTRATO DE PRESTAÇÃO DE SERVIÇO').
contract_metadata(contrato_ocs_0206_2020, partes, ['BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES', 'BRy TECNOLOGIA S.A']).
contract_metadata(contrato_ocs_0206_2020, contratante, 'BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES').
contract_metadata(contrato_ocs_0206_2020, contratado, 'BRy TECNOLOGIA S.A').
contract_metadata(contrato_ocs_0206_2020, cnpj_contratante, '33.657.248/0001-89').
contract_metadata(contrato_ocs_0206_2020, cnpj_contratado, '04.441.528/0001-57').
contract_metadata(contrato_ocs_0206_2020, data_autorizacao, '25/09/2020').
contract_metadata(contrato_ocs_0206_2020, ip_ati_degat, '02/2020').
contract_metadata(contrato_ocs_0206_2020, data_ip_ati_degat, '15/09/2020').
contract_metadata(contrato_ocs_0206_2020, rubrica_orcamentaria, '3101700020').
contract_metadata(contrato_ocs_0206_2020, rubrica_orcamentaria, '3101700040').
contract_metadata(contrato_ocs_0206_2020, centro_custo, 'BN00004000').
contract_metadata(contrato_ocs_0206_2020, lei_aplicavel, 'Lei nº 13.303/2016').
contract_metadata(contrato_ocs_0206_2020, regulamento, 'Regulamento de Formalização, Execução e Fiscalização dos Contratos Administrativos do Sistema BNDES').
contract_clause(contrato_ocs_0206_2020, clausula_primeira_objeto, 'CLÁUSULA PRIMEIRA – OBJETO', 'O presente Contrato tem por objeto a prestação de serviço de emissão de carimbo do tempo, como autoridade certificadora do tempo (ACT), dentro das especificações e normas da infraestrutura de Chaves Públicas Brasileiras (ICP-Brasil), conforme especificações constantes do Termo de Referência e da Proposta apresentada pela CONTRATADA, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_0206_2020, clausula_segunda_vigencia, 'CLÁUSULA SEGUNDA – VIGÊNCIA', 'O presente Contrato terá sua vigência iniciada, a partir da assinatura do Contrato, pelo prazo de 30 (trinta) meses, prorrogáveis por igual período.').
contract_clause(contrato_ocs_0206_2020, clausula_terceira_local_prazo_condicoes_execucao_objeto, 'CLÁUSULA TERCEIRA – LOCAL, PRAZO E CONDIÇÕES DE EXECUÇÃO DO OBJETO', 'A execução do objeto contratado respeitará as especificações constantes do Termo de Referência e da proposta apresentada pela CONTRATADA, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_0206_2020, clausula_quarta_niveis_servico, 'CLÁUSULA QUARTA – NÍVEIS DE SERVIÇO', 'Os serviços contratados deverão ser executados de acordo com os padrões de qualidade, disponibilidade e desempenho estipulados pelo BNDES, observados os níveis de serviço descritos no Anexo I (Termo de Referência) deste Contrato.').
contract_clause(contrato_ocs_0206_2020, clausula_quinta_recebimento_objeto, 'CLÁUSULA QUINTA – RECEBIMENTO DO OBJETO', 'O BNDES efetuará o recebimento do objeto, através do gestor mencionado na Cláusula de Obrigações do BNDES deste Contrato, observado o disposto no Anexo I (Termo de Referência) deste Contrato.').
contract_clause(contrato_ocs_0206_2020, clausula_sexta_preco, 'CLÁUSULA SEXTA – PREÇO', 'O BNDES pagará à CONTRATADA, pela execução do objeto contratado, o valor de até R$ 24.750,00 (vinte e quatro mil, setecentos e cinquenta reais), conforme Proposta apresentada (Anexo II deste Contrato), observado o disposto na Cláusula de Pagamento deste Instrumento, e a seguinte composição:          Parágrafo Primeiro No valor ajustado no caput desta Cláusula estão incluídos todos os insumos, encargos trabalhistas e tributos, inclusive contribuições fiscais e parafiscais, bem como quaisquer outras despesas necessárias à execução deste Contrato.  Parágrafo Segundo Na hipótese de o objeto ser, a critério do BNDES, parcialmente executado e recebido, os valores previstos nesta Cláusula serão proporcionalmente reduzidos, sem prejuízo da aplicação das penalidades cabíveis.  Parágrafo Terceiro Caso o BNDES não demande o total do objeto previsto neste Contrato, não será devida indenização à CONTRATADA.  Parágrafo Quarto A CONTRATADA deverá arcar com os ônus decorrentes de eventual equívoco no dimensionamento dos quantitativos de sua Proposta, devendo complementá-los, caso os quantitativos previstos inicialmente em sua Proposta não sejam satisfatórios para o atendimento ao objeto deste Contrato.').
contract_clause(contrato_ocs_0206_2020, clausula_setima_pagamento, 'CLÁUSULA SETIMA – PAGAMENTO', 'O BNDES efetuará o pagamento referente ao objeto deste Contrato, mensalmente, por meio de crédito em conta bancária, em até 10 (dez) dias úteis a contar da data de apresentação do documento fiscal ou equivalente legal (como nota fiscal, fatura, boleto bancário com código de barras, recibo de pagamento a autônomo), desde que tenha sido efetuado ateste pelo Gestor do Contrato das obrigações contratuais assumidas pela CONTRATADA, observado o disposto no Termo de Referência (Anexo I deste Contrato).   Parágrafo Primeiro  O documento fiscal ou equivalente legal deverá ser apresentado ao BNDES no mês de sua emissão e até o dia 25 (vinte e cinco) do mesmo – ou data anterior que viabilize o tempestivo recolhimento de ISS, se a legislação tributária municipal incidente assim exigir – possibilitando o cumprimento, pelo BNDES, das obrigações fiscais principais e acessórias decorrentes deste Contrato. Havendo impedimento legal para o cumprimento desse prazo, o documento fiscal ou equivalente legal deverá ser apresentado até o primeiro dia útil do mês seguinte, mediante prévia autorização do BNDES.   Parágrafo Segundo  Nas hipóteses em que o recebimento definitivo ocorrer após a entrega do documento fiscal ou equivalente legal, o BNDES terá até 10 (dez) dias úteis, a contar da data em que o objeto tiver sido recebido definitivamente, para efetuar o pagamento.  Parágrafo Terceiro  O primeiro documento fiscal ou equivalente legal terá como objeto de cobrança o período compreendido entre o dia de início da prestação dos serviços e o último dia desse mês, e os documentos fiscais ou equivalentes legais subsequentes terão como referência o período compreendido entre o primeiro e o último dia de cada mês. O último documento fiscal ou equivalente legal, por seu turno, referir-se-á ao período compreendido entre o primeiro dia do último mês da prestação dos serviços e o último dia de serviço prestado. Em todos os casos, o documento fiscal ou equivalente legal só poderá ser emitido e apresentado ao BNDES após a efetiva prestação do serviço, respeitado o disposto no Parágrafo anterior.  Parágrafo Quarto Para toda efetivação de pagamento, a CONTRATADA deverá encaminhar 1 (uma) via do documento fiscal ou equivalente legal à caixa de e-mail nfe@bndes.gov.br, ou, quando emitido em papel, ao Protocolo do Edifício de Serviços do BNDES no Rio de Janeiro – EDSERJ, localizado na Avenida República do Chile nº 100, Térreo, Centro, Rio de Janeiro, CEP 20031-917, no período compreendido entre 10h e 18h.  Parágrafo Quinto O documento fiscal ou equivalente legal deverá respeitar a legislação tributária e conter, minimamente, as seguintes informações: I. número da Ordem de Compra/Serviço – OCS; II. número SAP do Contrato; III. número do pedido SAP, a ser informado pelo Gestor do Contrato; IV. número da Folha de Registro de Serviços (FRS), a ser informado pelo Gestor do Contrato; V. descrição detalhada do objeto executado e dos respectivos valores; VI. período de referência da execução do objeto; VII. nome e número do CNPJ da CONTRATADA, cuja regularidade fiscal tenha sido avaliada na fase de habilitação, bem como o número de inscrição na Fazenda Municipal e/ou Estadual, conforme o caso; VIII. nome, telefone e e-mail do responsável pelo documento fiscal ou equivalente legal; IX. nome e número do banco e da agência, bem como o número da conta corrente da CONTRATADA, vinculada ao CNPJ constante do documento fiscal ou equivalente legal, com respectivos dígitos verificadores; X. tomador do serviço: Banco Nacional de Desenvolvimento Econômico e Social – BNDES; XI. CNPJ do tomador do serviço: 33.657.248/0001-89; XII. local de execução do objeto, emitindo-se um documento fiscal ou equivalente legal para cada Município em que o serviço seja prestado, se for o caso;  XIII. código do serviço, nos termos da lista anexa à Lei Complementar nº 116/2003, em concordância com as informações inseridas na Declaração de Informações para Fornecimento - DIF.  Parágrafo Sexto O documento fiscal ou equivalente legal emitido pela CONTRATADA deverá estar em conformidade com a legislação do Município onde a CONTRATADA esteja estabelecida, cuja regularidade fiscal foi avaliada na etapa de habilitação, e com as normas regulamentares aprovadas pela Secretaria da Receita Federal do Brasil, especialmente no que tange à retenção de tributos federais, sob pena de devolução do documento e interrupção do prazo para pagamento.   Parágrafo Sétimo Caso a CONTRATADA emita documento fiscal ou equivalente legal autorizado por Município diferente daquele onde se localiza o estabelecimento do BNDES tomador do serviço e destinatário da cobrança, deverá providenciar o cadastro junto à Secretaria Municipal de Fazenda ou órgão equivalente do Município do estabelecimento tomador, salvo quando se aplicar uma das exceções constantes dos incisos do artigo 3º da Lei Complementar Federal nº 116/03. A inexistência desse cadastro ou o cadastro em item diverso do faturado não constitui impeditivo ao processo de pagamento, mas um ônus a ser suportado pela CONTRATADA, uma vez que o BNDES está obrigado a reter na fonte a quantia equivalente ao ISS dos serviços faturados, conforme legislação aplicável.   Parágrafo Oitavo Ao documento fiscal ou equivalente legal deverão ser anexados: I. certidões de regularidade fiscal exigidas na fase de habilitação;  II. comprovante de que a CONTRATADA é optante do Simples Nacional, se for o caso;  III. em caso de isenção/imunidade tributária, documentos comprobatórios com a indicação do dispositivo legal que ampara a isenção/imunidade; e  IV. demais documentos solicitados pelo Gestor do Contrato, necessários ao pagamento do objeto contratado.   Parágrafo Nono Caso sejam verificadas divergências, o BNDES devolverá o documento fiscal ou equivalente legal ao CONTRATADA ou solicitará a emissão de carta de correção, quando cabível, interrompendo-se o prazo de pagamento até que este providencie as medidas saneadoras ou comprove a correção dos dados contestados pelo BNDES.   Parágrafo Décimo Os pagamentos a serem efetuados em favor da CONTRATADA estarão sujeitos, no que couber, às retenções de tributos, nos termos da legislação tributária e com base nas informações prestadas pela CONTRATADA.   Parágrafo Décimo Primeiro Além de outras hipóteses previstas em lei ou no Contrato, o BNDES poderá descontar, do montante expresso no documento fiscal ou equivalente legal, os valores referentes a multas, indenizações apuradas em processo administrativo, bem como qualquer obrigação que decorra do descumprimento da legislação pela CONTRATADA.  Parágrafo Décimo Segundo Caso o BNDES não efetue o pagamento na forma prevista nesta Cláusula, em decorrência de fato não atribuível à CONTRATADA, aos valores devidos serão acrescidos juros de mora de 0,5% (meio por cento) ao mês, pro rata tempore, calculados desde o dia do vencimento até a data da efetiva liquidação.').
contract_clause(contrato_ocs_0206_2020, clausula_oitava_equilibrio_economico_financeiro_contrato, 'CLÁUSULA OITAVA – EQUILÍBRIO ECONÔMICO-FINANCEIRO DO CONTRATO', 'O BNDES e a CONTRATADA têm direito ao equilíbrio econômico-financeiro do Contrato, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, a ser realizado mediante reajuste ou revisão de preços.   Parágrafo Primeiro O reajuste de preços, na forma prevista na legislação, poderá ser requerido pelo CONTRATADO a cada período de 12 (doze) meses, sendo o primeiro contado do dia 29/06/2020, data de apresentação da proposta (Anexo II deste Contrato), e os seguintes, do fato gerador anterior, adotando-se para tanto a aplicação do Índice de Custo de Tecnologia da Informação - ICTI, divulgado pelo Instituto de Pesquisa Econômica Aplicada – IPEA, ou outro índice que vier a substituí-lo, sobre o preço referido na Cláusula de Preço deste Instrumento.  Parágrafo Segundo A revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação do CONTRATADO, quando ocorrer fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado ao CONTRATADO nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte:  I. o CONTRATADO deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da proposta ou do último reajuste e do momento do pedido de revisão; e III. com o requerimento, o CONTRATADO deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da proposta ou do último reajuste e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado.  Parágrafo Terceiro Independentemente de solicitação, o BNDES poderá convocar o CONTRATADO para negociar a redução dos preços, mantendo o mesmo objeto contratado, na quantidade e nas especificações indicadas na proposta, em virtude da redução dos preços de mercado, ou de itens que compõem o custo, cabendo ao CONTRATADO apresentar as informações solicitadas pelo BNDES.   Parágrafo Quarto O CONTRATADO deverá solicitar o reajuste e/ou a revisão de preços até a prorrogação ou o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: I. caso o fato gerador do reajuste e/ou da revisão de preços ou a divulgação do índice de reajuste ocorra com antecedência inferior a 60 (sessenta) dias da prorrogação ou do encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste e/ou a revisão de preços; II. caso a assinatura do aditivo de prorrogação torne superveniente a ocorrência do fato gerador do reajuste, ou a divulgação do índice de reajuste ocorra após a prorrogação ou o encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste de preços; III. o BNDES deverá analisar o pedido de reajuste e/ou revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pelo CONTRATADO dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do BNDES, enquanto o CONTRATADO não apresentar a documentação solicitada para a comprovação da variação de custos; e IV. caso o CONTRATADO não solicite o reajuste e/ou revisão de preços nos prazos fixados acima, não fará jus aos efeitos retroativos ou, caso o Contrato esteja encerrado, operar-se-á a renúncia a eventual direito ao reajuste e/ou à revisão.  Parágrafo Quinto Se o processo de reajuste e/ou revisão de preços não for concluído até o vencimento do Contrato, e este for prorrogado, sua continuidade após o reequilíbrio econômico-financeiro ficará condicionada à manutenção da proposta do CONTRATADO como a condição mais vantajosa para o BNDES, podendo este: I. realizar negociação de preços junto ao CONTRATADO, de forma a viabilizar a continuidade do ajuste, quando os novos valores fixados após o reajuste e/ou a revisão de preços estiverem acima do patamar apurado no mercado; ou  II. rescindir o Contrato, mediante aviso prévio ao CONTRATADO, com antecedência de 30 (trinta) dias, quando resultar infrutífera a negociação indicada no inciso anterior.  Parágrafo Sexto Na ocorrência da hipótese prevista no inciso II do Parágrafo anterior, o CONTRATADO fará jus à integralidade dos valores apurados no processo de reajuste e/ou revisão de preços até o término do Contrato, não podendo, todavia, reclamar qualquer indenização em razão da rescisão do mesmo.').
contract_clause(contrato_ocs_0206_2020, clausula_nona_matriz_riscos, 'CLÁUSULA NONA – MATRIZ DE RISCOS', 'O BNDES e a CONTRATADA, tendo como premissa a obtenção do melhor custo contratual mediante a alocação do risco à parte com maior capacidade para geri-lo e absorvê-lo, identificam os riscos decorrentes da relação contratual e, sem prejuízo de outras previsões contratuais, estabelecem os respectivos responsáveis na Matriz de Riscos constante do Anexo III deste Contrato.   Parágrafo Primeiro É vedada a celebração de aditivos decorrentes de eventos supervenientes alocados, na Matriz de Riscos, como de responsabilidade da CONTRATADA.').
contract_clause(contrato_ocs_0206_2020, clausula_decima_obrigacoes_contratada, 'CLÁUSULA DECIMA – OBRIGAÇÕES DA CONTRATADA', 'Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações da CONTRATADA:  I - A Contratada deverá designar um preposto perante o BNDES para assuntos relativos à execução dos serviços contratados.  II - A comunicação do BNDES com o preposto será realizada obrigatoriamente em português do Brasil. III-O BNDES poderá solicitar reuniões mensais com o preposto nas dependências do BNDES no Rio de Janeiro, com a finalidade de tratar questões referentes ao Contrato. III .1 A critério do BNDES, as reuniões poderão ser remotas, utilizando o sistema de videoconferência do BNDES. Neste caso, a Contratada poderá participar da reunião a partir das dependências do BNDES, atualmente existentes em São Paulo, Brasília e Recife. Nessa modalidade não há limite para o número de reuniões por ano.  III.2 Extraordinariamente, a critério do BNDES, poderão ser realizadas reuniões extraordinárias para resolver problemas específicos, tais como, ocorrência de incidentes frequentes, desempenho ruim da aplicação, problemas na instalação (disponibilização) ou migração de versão, chamados em aberto além dos prazos máximos estipulados, dentre outros.  IV - Manter durante a vigência deste Contrato todas as condições exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES, sobretudo o credenciamento como ACT junto ao ITI; V - Comunicar a imposição de penalidade que acarrete o impedimento de contratar com o BNDES, bem como a eventual perda dos pressupostos para a dispensa de licitação; VI - Reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução ou de materiais empregados; VII - Reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato; VIII - Pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir da Contratada a comprovação de sua regularidade; IX - Permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; X - Obedecer às instruções e aos procedimentos estabelecidos pelo BNDES para a adequada execução do Contrato; XI - Permitir ao Banco Central do Brasil acesso a termos firmados, documentos e informações atinentes aos serviços prestados, bem como às suas dependências, nos termos do § 1º do artigo 33 da Resolução CMN nº 4.557/2017; XII - Atender às solicitações do BNDES relativas à transição contratual entre a Contratada e o seu sucessor na execução do serviço, prestando todo o suporte, inclusive a capacitação dos profissionais de seu sucessor, a fim de que o objeto contratado não seja interrompido; XIII - Garantir que o objeto do Contrato não infringe quaisquer direitos autorais, patentes ou registros, inclusive marcas, know-how ou trade-secrets, sendo responsável pelos prejuízos, inclusive honorários de advogado, custas e despesas decorrentes de qualquer medida ou processo judicial ou administrativo iniciado em face do BNDES, por acusação da espécie, podendo a Contratada ser instada a intervir no processo;  XIV - Manter sigilo relativamente ao objeto contratado, bem como sobre dados, documentos, especificações técnicas ou comerciais, não tornadas públicas pelo BNDES, de que venha a ter conhecimento em virtude da contratação, bem como a respeito da execução e resultados obtidos na prestação de serviços, inclusive após o término do prazo de vigência do(s) Contrato(s), sendo vedada a divulgação dos referidos resultados a terceiros em geral, e em especial a quaisquer meios de comunicação públicos e/ou privados; XV - A Contratada obriga-se, ao final da vigência do Contrato, a descartar de forma definitiva, ou seja, de forma a impedir a sua recuperação total ou parcial posteriormente, toda informação do BNDES gerada, mantida, recebida, manipulada ou produzida durante a execução do Contrato que a Contratada esteja custodiando; XVI - O acesso às informações do BNDES às quais a Contratada venha a ter contato deve ser permitido somente aos profissionais expressamente designados para a execução dos serviços contratados, não sendo permitido, portanto, o acesso de pessoas externas à empresa contratada ou mesmo de profissionais da Contratada não designados para a prestação do serviço contratado ou que ainda não tenham assinado o devido Termo de Confidencialidade; e XVII - Toda informação produzida, acessada ou manipulada no âmbito da prestação do serviço contratado é de propriedade do BNDES, e deve ser considerada e tratada como sigilosa a menos que haja manifestação contrária e expressa do BNDES; XXIII - A Contratada obriga-se, ao final da vigência do Contrato, a exportar e entregar ao BNDES todos os dados (logs) de uso do SCT em formato padrão aberto XML ou CSV. XVIII - providenciar, perante a Receita Federal do Brasil – RFB, comprovando ao BNDES, sua exclusão obrigatória do Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se a CONTRATADA, quando optante: a) extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) enquadrar-se em alguma das exceções previstas no artigo 17 da Lei Complementar nº 123/2006; XXIX - responsabilizar-se pelo cumprimento das normas de segurança das dependências do BNDES por parte dos profissionais alocados na execução dos serviços, quanto ao porte de identificação e a utilização dos acessos indicados pelo BNDES.').
contract_clause(contrato_ocs_0206_2020, clausula_decima_primeira_conduta_etica_contratada_bndes, 'CLÁUSULA DÉCIMA PRIMEIRA– CONDUTA ÉTICA DA CONTRATADA E DO BNDES A CONTRATADA e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade administrativa e da impessoalidade, além de pautar sua conduta em preceitos éticos e, em especial, na sua responsabilidade socioambiental.  Parágrafo Primeiro Em atendimento ao disposto no caput desta Cláusula, a CONTRATADA obriga-se, inclusive, a: I. não oferecer, prometer, dar, autorizar, solicitar ou aceitar, direta ou indiretamente, qualquer vantagem indevida, seja pecuniária ou de outra natureza, consistente em fraude, ato de corrupção ou qualquer outra violação de dever legal, relacionada com este Contrato, bem como a tomar todas as medidas ao seu alcance para impedir administradores, empregados, agentes, representantes, fornecedores, contratados ou subcontratados, seus ou de suas controladas, de fazê-lo; II. impedir o favorecimento ou a participação de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do presente Contrato; III. providenciar para que não sejam alocados, na execução dos serviços, familiares de dirigente ou empregado do Sistema BNDES, considerando-se familiar o cônjuge, o companheiro ou o parente em linha reta ou colateral, por consanguinidade ou afinidade, até o terceiro grau; IV. observar o Código de Ética do Sistema BNDES vigente ao tempo da contratação, bem como a Política de Conduta e Integridade no âmbito das licitações e contratos administrativos e a Política Corporativa Anticorrupção do Sistema BNDES, assegurando-se de que seus representantes, administradores e todos os profissionais envolvidos na execução do objeto pautem seu comportamento e sua atuação pelos princípios neles constantes; e V. adotar, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição.  Parágrafo Segundo O BNDES recomenda, à CONTRATADA, considerar em suas práticas de gestão a implantação de programa de integridade estruturado, voltado à prevenção, detecção e remediação da ocorrência de fraudes e atos de corrupção.  Parágrafo Terceiro Verificada uma das situações mencionadas nos incisos II e III do Parágrafo Primeiro desta Cláusula, compete à CONTRATADA afastar imediatamente da execução do Contrato os agentes que impliquem a ocorrência dos impedimentos e favorecimentos aludidos, além de comunicar tal fato ao BNDES, sem prejuízo de apuração de sua responsabilidade, caso tenha agido de má-fé.  Parágrafo Quarto A CONTRATADA declara ter conhecimento do Código de Ética do Sistema BNDES, bem como da Política de Conduta e Integridade no âmbito das licitações e contratos administrativos e da Política Corporativa Anticorrupção do Sistema BNDES, que poderão ser consultados por intermédio do sítio eletrônico www.bndes.gov.br ou requisitados ao Gestor do Contrato.  Parágrafo Quinto Eventuais irregularidades ou descumprimentos das normas internas do BNDES ou da legislação vigente podem ser denunciados à Ouvidoria por qualquer cidadão através dos seguintes canais: página na internet (www.bndes.gov.br/ouvidoria); correio (Caixa Postal 15054, CEP 20031-120, Rio de Janeiro – RJ); e telefone (0800 702 6307).', 'CLÁUSULA DÉCIMA PRIMEIRA– CONDUTA ÉTICA DA CONTRATADA E DO BNDES A CONTRATADA e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade administrativa e da impessoalidade, além de pautar sua conduta em preceitos éticos e, em especial, na sua responsabilidade socioambiental.  Parágrafo Primeiro Em atendimento ao disposto no caput desta Cláusula, a CONTRATADA obriga-se, inclusive, a: I. não oferecer, prometer, dar, autorizar, solicitar ou aceitar, direta ou indiretamente, qualquer vantagem indevida, seja pecuniária ou de outra natureza, consistente em fraude, ato de corrupção ou qualquer outra violação de dever legal, relacionada com este Contrato, bem como a tomar todas as medidas ao seu alcance para impedir administradores, empregados, agentes, representantes, fornecedores, contratados ou subcontratados, seus ou de suas controladas, de fazê-lo; II. impedir o favorecimento ou a participação de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do presente Contrato; III. providenciar para que não sejam alocados, na execução dos serviços, familiares de dirigente ou empregado do Sistema BNDES, considerando-se familiar o cônjuge, o companheiro ou o parente em linha reta ou colateral, por consanguinidade ou afinidade, até o terceiro grau; IV. observar o Código de Ética do Sistema BNDES vigente ao tempo da contratação, bem como a Política de Conduta e Integridade no âmbito das licitações e contratos administrativos e a Política Corporativa Anticorrupção do Sistema BNDES, assegurando-se de que seus representantes, administradores e todos os profissionais envolvidos na execução do objeto pautem seu comportamento e sua atuação pelos princípios neles constantes; e V. adotar, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição.  Parágrafo Segundo O BNDES recomenda, à CONTRATADA, considerar em suas práticas de gestão a implantação de programa de integridade estruturado, voltado à prevenção, detecção e remediação da ocorrência de fraudes e atos de corrupção.  Parágrafo Terceiro Verificada uma das situações mencionadas nos incisos II e III do Parágrafo Primeiro desta Cláusula, compete à CONTRATADA afastar imediatamente da execução do Contrato os agentes que impliquem a ocorrência dos impedimentos e favorecimentos aludidos, além de comunicar tal fato ao BNDES, sem prejuízo de apuração de sua responsabilidade, caso tenha agido de má-fé.  Parágrafo Quarto A CONTRATADA declara ter conhecimento do Código de Ética do Sistema BNDES, bem como da Política de Conduta e Integridade no âmbito das licitações e contratos administrativos e da Política Corporativa Anticorrupção do Sistema BNDES, que poderão ser consultados por intermédio do sítio eletrônico www.bndes.gov.br ou requisitados ao Gestor do Contrato.  Parágrafo Quinto Eventuais irregularidades ou descumprimentos das normas internas do BNDES ou da legislação vigente podem ser denunciados à Ouvidoria por qualquer cidadão através dos seguintes canais: página na internet (www.bndes.gov.br/ouvidoria); correio (Caixa Postal 15054, CEP 20031-120, Rio de Janeiro – RJ); e telefone (0800 702 6307).').
contract_clause(contrato_ocs_0206_2020, clausula_decima_segunda_sigilo_informacoes, 'CLÁUSULA DÉCIMA SEGUNDA – SIGILO DAS INFORMAÇÕES Caso o CONTRATADO venha a ter acesso a dados, materiais, documentos e informações de natureza sigilosa, direta ou indiretamente, em decorrência da execução do objeto contratual, deverá manter o sigilo dos mesmos, bem como orientar os profissionais envolvidos a cumprir esta obrigação, respeitando-se as diretrizes e normas da Política Corporativa de Segurança da Informação do BNDES.  Parágrafo Único Assim que solicitado pelo Gestor do Contrato, o CONTRATADO deverá providenciar a assinatura, por seu representante legal e pelos profissionais que tiverem acesso a informações sigilosas, dos Termos de Confidencialidade a serem disponibilizados pelo BNDES.', 'CLÁUSULA DÉCIMA SEGUNDA – SIGILO DAS INFORMAÇÕES Caso o CONTRATADO venha a ter acesso a dados, materiais, documentos e informações de natureza sigilosa, direta ou indiretamente, em decorrência da execução do objeto contratual, deverá manter o sigilo dos mesmos, bem como orientar os profissionais envolvidos a cumprir esta obrigação, respeitando-se as diretrizes e normas da Política Corporativa de Segurança da Informação do BNDES.  Parágrafo Único Assim que solicitado pelo Gestor do Contrato, o CONTRATADO deverá providenciar a assinatura, por seu representante legal e pelos profissionais que tiverem acesso a informações sigilosas, dos Termos de Confidencialidade a serem disponibilizados pelo BNDES.').
contract_clause(contrato_ocs_0206_2020, clausula_decima_terceira_obrigações_bndes, 'CLÁUSULA DÉCIMA TERCEIRA – OBRIGAÇÕES DO BNDES Além de outras obrigações estipuladas neste Instrumento, em seus anexos ou nas leis, vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do BNDES: I. realizar os pagamentos devidos à CONTRATADA, nas condições estabelecidas neste Contrato; II. designar, como Gestor do Contrato, Luís Felipe santos Silva que atualmente exerce a função de gerente da ATI/DESIS4/GESEC, a quem caberá o acompanhamento, a fiscalização e a avaliação da execução do serviço, bem como a liquidação da despesa e o atestado de cumprimento das obrigações assumidas; III. designar como gestor substituto, quem estiver na função de substituto  do gerente da ATI/DESIS4/GESEC;.  IV. alterar, quando conveniente, o Gestor do Contrato e/ou o seu substituto, por outro profissional, mediante comunicação escrita à CONTRATADA; V. fornecer à CONTRATADA, quando solicitado ao Gestor do Contrato, cópia do Código de Ética do Sistema BNDES, da Política de Conduta e Integridade no âmbito das licitações e contratos administrativos, da Política Corporativa Anticorrupção do Sistema BNDES e da Política Corporativa de Segurança da Informação do BNDES; VI. colocar à disposição da CONTRATADA todas as informações necessárias à perfeita execução do serviço objeto deste Contrato; e VII. comunicar à CONTRATADA, por escrito:  a) quaisquer instruções ou procedimentos sobre assuntos relacionados ao Contrato; b) a abertura de procedimento administrativo para a apuração de condutas irregulares da CONTRATADA, concedendo-lhe prazo para defesa; e c) a aplicação de eventual penalidade, nos termos deste Contrato.', 'CLÁUSULA DÉCIMA TERCEIRA – OBRIGAÇÕES DO BNDES Além de outras obrigações estipuladas neste Instrumento, em seus anexos ou nas leis, vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do BNDES: I. realizar os pagamentos devidos à CONTRATADA, nas condições estabelecidas neste Contrato; II. designar, como Gestor do Contrato, Luís Felipe santos Silva que atualmente exerce a função de gerente da ATI/DESIS4/GESEC, a quem caberá o acompanhamento, a fiscalização e a avaliação da execução do serviço, bem como a liquidação da despesa e o atestado de cumprimento das obrigações assumidas; III. designar como gestor substituto, quem estiver na função de substituto  do gerente da ATI/DESIS4/GESEC;.  IV. alterar, quando conveniente, o Gestor do Contrato e/ou o seu substituto, por outro profissional, mediante comunicação escrita à CONTRATADA; V. fornecer à CONTRATADA, quando solicitado ao Gestor do Contrato, cópia do Código de Ética do Sistema BNDES, da Política de Conduta e Integridade no âmbito das licitações e contratos administrativos, da Política Corporativa Anticorrupção do Sistema BNDES e da Política Corporativa de Segurança da Informação do BNDES; VI. colocar à disposição da CONTRATADA todas as informações necessárias à perfeita execução do serviço objeto deste Contrato; e VII. comunicar à CONTRATADA, por escrito:  a) quaisquer instruções ou procedimentos sobre assuntos relacionados ao Contrato; b) a abertura de procedimento administrativo para a apuração de condutas irregulares da CONTRATADA, concedendo-lhe prazo para defesa; e c) a aplicação de eventual penalidade, nos termos deste Contrato.').
contract_clause(contrato_ocs_0206_2020, clausula_decima_quarta_cessao_contrato_credito_sucessao_contratual_subcontratação, 'CLÁUSULA DÉCIMA QUARTA – CESSÃO DE CONTRATO OU DE CRÉDITO, SUCESSÃO CONTRATUAL E SUBCONTRATAÇÃO  É vedada a cessão deste Contrato, total ou parcialmente, ou de qualquer crédito dele decorrente, bem como a emissão, por parte da CONTRATADA, de qualquer título de crédito em razão do mesmo.  Parágrafo Primeiro É vedada a sucessão contratual, salvo nas hipóteses em que a CONTRATADA realizar as operações societárias de fusão, cisão ou incorporação, condicionada aos seguintes requisitos: I. aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal alteração contratual; e II. manutenção de todas as condições contratuais e requisitos de habilitação originais.  Parágrafo Segundo Caso ocorra a sucessão contratual admitida no Parágrafo anterior, o sucessor assumirá integralmente a posição do sucedido, passando a ser responsável pela execução do presente Contrato, fazendo jus, por conseguinte, ao recebimento dos créditos dele decorrentes.  Parágrafo Terceiro É vedada a subcontratação para a execução do objeto deste Contrato.', 'CLÁUSULA DÉCIMA QUARTA – CESSÃO DE CONTRATO OU DE CRÉDITO, SUCESSÃO CONTRATUAL E SUBCONTRATAÇÃO  É vedada a cessão deste Contrato, total ou parcialmente, ou de qualquer crédito dele decorrente, bem como a emissão, por parte da CONTRATADA, de qualquer título de crédito em razão do mesmo.  Parágrafo Primeiro É vedada a sucessão contratual, salvo nas hipóteses em que a CONTRATADA realizar as operações societárias de fusão, cisão ou incorporação, condicionada aos seguintes requisitos: I. aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal alteração contratual; e II. manutenção de todas as condições contratuais e requisitos de habilitação originais.  Parágrafo Segundo Caso ocorra a sucessão contratual admitida no Parágrafo anterior, o sucessor assumirá integralmente a posição do sucedido, passando a ser responsável pela execução do presente Contrato, fazendo jus, por conseguinte, ao recebimento dos créditos dele decorrentes.  Parágrafo Terceiro É vedada a subcontratação para a execução do objeto deste Contrato.').
contract_clause(contrato_ocs_0206_2020, clausula_decima_quinta_penalidades, 'CLÁUSULA DÉCIMA QUINTA – PENALIDADES Em caso de inexecução total ou parcial do Contrato, inclusive de descumprimento de exigência expressamente formulada pelo BNDES ou de inobservância de qualquer obrigação legal, bem como em caso de mora, sem motivo justificado, a CONTRATADA ficará sujeita às seguintes penalidades: I - Advertência; II – Multa: II.1 - Na hipótese de a Contratada deixar de respeitar os prazos definidos nos itens 5.1 ou 5.2.2 das Especificações Técnicas, excedendo-os em mais de 30 dias, por problemas alheios ao BNDES, além de eventual ajuste de pagamento estabelecido no item 7.2.1 das Especificações Técnicas, ficará sujeita à aplicação de multa de até 1% (um por cento), para cada dia útil de atraso, calculado sobre o valor total do serviço de instalação (disponibilização) do Serviço ou, na ausência desse valor, sobre o valor de uso do SCT, limitado a 10% (dez por cento) do valor global do contrato; II.2 - Na hipótese de a Contratada deixar de garantir o nível de serviço previsto no item 7.3 das Especificações Técnicas, e sendo ultrapassado o limite de ajuste de pagamento estabelecido no item 7.7 das Especificações Técnicas, será aplicada multa sobre o valor da fatura mensal do mês de ocorrência do descumprimento, referente ao uso do SCT, de até 1% (um por cento) por dia útil excedente de descumprimento do respectivo nível de serviço, limitado a 10% (dez por cento) do valor global do respectivo Contrato; II.3 - Multa de até 10% (dez por cento), apurada de acordo com a gravidade da infração, incidindo sobre o valor global do Contrato, em razão do descumprimento de outras obrigações contratuais não abrangidas nos itens 9.1.2 e 9.1.3 das Especificações Técnicas; e III - Suspensão temporária de participação em licitação e impedimento de contratar com o BNDES, por prazo não superior a 2 (dois) anos, apurado de acordo com a gravidade da infração.   Parágrafo Primeiro As penalidades indicadas nesta Cláusula somente poderão ser aplicadas após procedimento administrativo, e desde que assegurados o contraditório e a ampla defesa, facultada à CONTRATADA a defesa prévia, no prazo de 10 (dez) dias úteis.  Parágrafo Segundo Contra a decisão de aplicação de penalidade, a CONTRATADA poderá interpor o recurso cabível, na forma e no prazo previstos no Regulamento de Formalização, Execução e Fiscalização de Contratos Administrativos do Sistema BNDES. Parágrafo Terceiro A imposição de sanção prevista nesta Cláusula não impede a extinção do Contrato pelo BNDES, nos termos da legislação aplicável e da Cláusula de Extinção do Contrato.   Parágrafo Quarto A multa prevista nesta Cláusula poderá ser aplicada juntamente com as demais penalidades, porém limitada a 30% (trinta por cento) do valor global do CONTRATO.   Parágrafo Quinto A multa aplicada à CONTRATADA e os prejuízos causados ao BNDES serão deduzidos de quaisquer créditos a ela devidos, ressalvada a possibilidade de cobrança judicial da diferença eventualmente não coberta pelos mencionados créditos.  Parágrafo Sexto No caso de uso indevido de informações sigilosas, observar-se-ão, no que couber, os termos da Lei nº 12.527/2011 e do Decreto nº 7.724/2012.  Parágrafo Sétimo No caso de atos lesivos à Administração Pública, nacional ou estrangeira, observar-se-ão os termos da Lei nº 12.846/2013.  Parágrafo Oitavo A sanção prevista no Inciso III desta Cláusula também poderá ser aplicada às sociedades ou profissionais que: I. tenham sofrido condenação definitiva por praticarem, por meios dolosos, fraude fiscal no recolhimento de quaisquer tributos; II. tenham praticado atos ilícitos visando frustrar os objetivos da licitação; III. demonstrem não possuir idoneidade para contratar com o BNDES em virtude de atos ilícitos praticados.', 'CLÁUSULA DÉCIMA QUINTA – PENALIDADES Em caso de inexecução total ou parcial do Contrato, inclusive de descumprimento de exigência expressamente formulada pelo BNDES ou de inobservância de qualquer obrigação legal, bem como em caso de mora, sem motivo justificado, a CONTRATADA ficará sujeita às seguintes penalidades: I - Advertência; II – Multa: II.1 - Na hipótese de a Contratada deixar de respeitar os prazos definidos nos itens 5.1 ou 5.2.2 das Especificações Técnicas, excedendo-os em mais de 30 dias, por problemas alheios ao BNDES, além de eventual ajuste de pagamento estabelecido no item 7.2.1 das Especificações Técnicas, ficará sujeita à aplicação de multa de até 1% (um por cento), para cada dia útil de atraso, calculado sobre o valor total do serviço de instalação (disponibilização) do Serviço ou, na ausência desse valor, sobre o valor de uso do SCT, limitado a 10% (dez por cento) do valor global do contrato; II.2 - Na hipótese de a Contratada deixar de garantir o nível de serviço previsto no item 7.3 das Especificações Técnicas, e sendo ultrapassado o limite de ajuste de pagamento estabelecido no item 7.7 das Especificações Técnicas, será aplicada multa sobre o valor da fatura mensal do mês de ocorrência do descumprimento, referente ao uso do SCT, de até 1% (um por cento) por dia útil excedente de descumprimento do respectivo nível de serviço, limitado a 10% (dez por cento) do valor global do respectivo Contrato; II.3 - Multa de até 10% (dez por cento), apurada de acordo com a gravidade da infração, incidindo sobre o valor global do Contrato, em razão do descumprimento de outras obrigações contratuais não abrangidas nos itens 9.1.2 e 9.1.3 das Especificações Técnicas; e III - Suspensão temporária de participação em licitação e impedimento de contratar com o BNDES, por prazo não superior a 2 (dois) anos, apurado de acordo com a gravidade da infração.   Parágrafo Primeiro As penalidades indicadas nesta Cláusula somente poderão ser aplicadas após procedimento administrativo, e desde que assegurados o contraditório e a ampla defesa, facultada à CONTRATADA a defesa prévia, no prazo de 10 (dez) dias úteis.  Parágrafo Segundo Contra a decisão de aplicação de penalidade, a CONTRATADA poderá interpor o recurso cabível, na forma e no prazo previstos no Regulamento de Formalização, Execução e Fiscalização de Contratos Administrativos do Sistema BNDES. Parágrafo Terceiro A imposição de sanção prevista nesta Cláusula não impede a extinção do Contrato pelo BNDES, nos termos da legislação aplicável e da Cláusula de Extinção do Contrato.   Parágrafo Quarto A multa prevista nesta Cláusula poderá ser aplicada juntamente com as demais penalidades, porém limitada a 30% (trinta por cento) do valor global do CONTRATO.   Parágrafo Quinto A multa aplicada à CONTRATADA e os prejuízos causados ao BNDES serão deduzidos de quaisquer créditos a ela devidos, ressalvada a possibilidade de cobrança judicial da diferença eventualmente não coberta pelos mencionados créditos.  Parágrafo Sexto No caso de uso indevido de informações sigilosas, observar-se-ão, no que couber, os termos da Lei nº 12.527/2011 e do Decreto nº 7.724/2012.  Parágrafo Sétimo No caso de atos lesivos à Administração Pública, nacional ou estrangeira, observar-se-ão os termos da Lei nº 12.846/2013.  Parágrafo Oitavo A sanção prevista no Inciso III desta Cláusula também poderá ser aplicada às sociedades ou profissionais que: I. tenham sofrido condenação definitiva por praticarem, por meios dolosos, fraude fiscal no recolhimento de quaisquer tributos; II. tenham praticado atos ilícitos visando frustrar os objetivos da licitação; III. demonstrem não possuir idoneidade para contratar com o BNDES em virtude de atos ilícitos praticados.').
contract_clause(contrato_ocs_0206_2020, clausula_decima_sexta_alterações_contratuais, 'CLÁUSULA DECIMA SEXTA – ALTERAÇÕES CONTRATUAIS O presente Contrato poderá ser alterado, por acordo entre as partes, nas hipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou contratualmente previstas, observando-se que: I. as alterações devem preservar o equilíbrio econômico-financeiro do Contrato; e II. é vedada a modificação contratual que desnature o objeto da contratação ou afete as condições essenciais previstas no Termo de Referência (Anexo I deste Contrato).  Parágrafo Primeiro Em atenção aos princípios que regem as relações contratuais, nas hipóteses em que for imprescindível a alteração deste Contrato para viabilizar sua plena execução, conforme demonstrado em processo administrativo, não caberá a recusa das partes à respectiva formalização, salvo em caso de justo motivo, devidamente comprovado pela parte que o alegar.  Parágrafo Segundo A parte que, injustificadamente, se recusar a promover a alteração contratual indicada no Parágrafo anterior, deverá responder pelos danos eventualmente causados, sem prejuízo das demais consequências previstas neste Instrumento e na legislação vigente.  Parágrafo Terceiro As alterações contratuais serão formalizadas mediante instrumento aditivo, ressalvadas as hipóteses legais que admitem a alteração por apostilamento e os pequenos ajustes necessários à eventual correção de erros materiais ou à alteração de dados acessórios do Contrato, que poderão ser formalizados por meio epistolar.', 'CLÁUSULA DECIMA SEXTA – ALTERAÇÕES CONTRATUAIS O presente Contrato poderá ser alterado, por acordo entre as partes, nas hipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou contratualmente previstas, observando-se que: I. as alterações devem preservar o equilíbrio econômico-financeiro do Contrato; e II. é vedada a modificação contratual que desnature o objeto da contratação ou afete as condições essenciais previstas no Termo de Referência (Anexo I deste Contrato).  Parágrafo Primeiro Em atenção aos princípios que regem as relações contratuais, nas hipóteses em que for imprescindível a alteração deste Contrato para viabilizar sua plena execução, conforme demonstrado em processo administrativo, não caberá a recusa das partes à respectiva formalização, salvo em caso de justo motivo, devidamente comprovado pela parte que o alegar.  Parágrafo Segundo A parte que, injustificadamente, se recusar a promover a alteração contratual indicada no Parágrafo anterior, deverá responder pelos danos eventualmente causados, sem prejuízo das demais consequências previstas neste Instrumento e na legislação vigente.  Parágrafo Terceiro As alterações contratuais serão formalizadas mediante instrumento aditivo, ressalvadas as hipóteses legais que admitem a alteração por apostilamento e os pequenos ajustes necessários à eventual correção de erros materiais ou à alteração de dados acessórios do Contrato, que poderão ser formalizados por meio epistolar.').
contract_clause(contrato_ocs_0206_2020, clausula_decima_setima_extincao_do_contrato, 'CLÁUSULA DÉCIMA SETIMA – EXTINÇÃO DO CONTRATO', 'O presente Contrato poderá ser extinto de acordo com as hipóteses previstas na legislação, convencionando-se, ainda, que é cabível a sua resolução: I. em razão do inadimplemento total ou parcial de qualquer de suas obrigações, cabendo à parte inocente notificar a outra por escrito, assinalando-lhe prazo razoável para o cumprimento das obrigações, quando o mesmo não for previamente fixado neste instrumento ou em seus anexos; II. na ausência de liberação, por parte do BNDES, de área, local ou objeto necessário para a sua execução, nos prazos contratuais; III. em virtude da suspensão da execução do Contrato, por ordem escrita do BNDES, por prazo superior a 120 (cento e vinte) dias ou ainda por repetidas suspensões que totalizem o mesmo prazo; IV. quando for decretada a falência da CONTRATADA; V. caso a CONTRATADA perca uma das condições de habilitação exigidas quando da contratação; VI. na hipótese de descumprimento do previsto na Cláusula de Cessão de Contrato ou de Crédito, Sucessão Contratual e Subcontratação; VII. caso a CONTRATADA seja declarada inidônea pela União, por Estado ou pelo Distrito Federal;  VIII. em função da suspensão do direito de a CONTRATADA licitar ou contratar com o BNDES; IX. na hipótese de caracterização de ato lesivo à Administração Pública, nos termos da Lei nº 12.846/2013, cometido pela CONTRATADA no processo de contratação ou por ocasião da execução contratual; X. em razão dissolução da CONTRATADA;  XI. quando da ocorrência de caso fortuito ou de força maior, regularmente comprovado, impeditivo da execução do Contrato. XII. em decorrência de atraso, lentidão ou paralisação injustificáveis da execução do objeto do Contrato, que caracterize a impossibilidade de sua conclusão no prazo pactuado.  Parágrafo Primeiro Caracteriza inadimplemento das obrigações de pagamento pecuniário do presente Contrato, a mora superior a 90 (noventa) dias.  Parágrafo Segundo Os casos de extinção contratual convencionados no caput desta Cláusula deverão ser precedidos de notificação escrita à outra parte do Contrato e de oportunidade de defesa, dispensada a necessidade de interpelação judicial.').
contract_clause(contrato_ocs_0206_2020, clausula_decima_oitava_disposições_finais, 'CLÁUSULA DÉCIMA OITAVA – DISPOSIÇÕES FINAIS', 'Este Contrato representa todo o acordo entre as partes com relação ao objeto nele previsto.   Parágrafo Primeiro Integram este Contrato o Termo de Referência, a Proposta Comercial e a Matriz de Risco respectivamente, Anexos I, II e III ao presente Instrumento, no que com este não colidir, bem como com as disposições legais aplicáveis, observando-se que, ocorrendo conflitos de interpretação entre as disposições contratuais e de seus anexos, prevalecerá o disposto no Contrato e na legislação em vigor. Parágrafo Segundo A omissão ou tolerância quanto à exigência do estrito cumprimento das obrigações contratuais ou ao exercício de prerrogativa decorrente deste Contrato não constituirá renúncia ou novação nem impedirá as partes de exercerem os seus direitos a qualquer tempo.').
contract_clause(contrato_ocs_0206_2020, clausula_decima_nona_foro, 'CLÁUSULA DÉCIMA NONA – FORO', 'É competente o foro da cidade do Rio de Janeiro (RJ) para solucionar eventuais litígios decorrentes deste Contrato, afastado qualquer outro, por mais privilegiado que seja.  As folhas deste Contrato foram conferidas por Márcio Oliveira da Rocha, advogado do BNDES, inscrito na OAB/RJ sob o nº 139.195, por autorização do representante legal que o assina.  E, por estarem assim justos e contratados, firmam o presente Contrato OCS nº 0206/2020, juntamente com as testemunhas abaixo.  Reputa-se celebrado o presente Contrato na última data em que for registrada a assinatura dos representantes Legais do BNDES.              Rio de Janeiro, 30 de setembro de 2020.   _____________________________________________________________________ BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES    _____________________________________________________________________ BRy TECNOLOGIA S.A  Testemunhas:  _________________________________ _________________________________ Nome/CPF: Nome/CPF: RAFAEL FERREIRA GODINHO:03327905924033.279.059-24Emitido por: AC SERASA RFB v5Data: 01/10/2020ALEXANDRE DE CARLOS BACK:60086483900600.864.839-00Emitido por: AC SERASA RFB v5Data: 01/10/2020HELENA MARIA CHAVES BOAL:01664072756016.640.727-56Emitido por: AC SOLUTI MultiplaData: 02/10/2020').

% ===== END =====
